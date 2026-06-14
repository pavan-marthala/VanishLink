import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/core/services/permission_manager.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_event.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_state.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart' as ck;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';

import 'ringtone_service.dart';
import 'call_notification_service.dart';
import 'call_presentation_adapter.dart';
import 'package:vanish_link/features/chat/domain/services/webrtc_service.dart';
import 'call_lifecycle_manager.dart';

class CallCoordinator {
  final CallRepository _callRepository;
  final PresenceRepository _presenceRepository;
  final RingtoneService _ringtoneService;
  final CallNotificationService _notificationService;
  final CallPresentationAdapter _callKitAdapter;
  final WebRtcService _webRtcService;
  final FirebaseAuth _auth;
  late final CallLifecycleManager _lifecycleManager;
  
  StreamSubscription<CallState>? _blocSubscription;
  StreamSubscription<ck.CallEvent?>? _callKitSubscription;
  StreamSubscription<String>? _webRtcStateSub;
  StreamSubscription<Map<String, dynamic>>? _readyStatesSub;
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;
  CallState? _previousState;

  bool _localReadySent = false;
  bool _activePromotionSent = false;
  String? _lastCleanedCallId;
  String? _currentCallId;
  bool _isBusy = false;
  bool _callInProgress = false;
  CallModel? _activeCall;
  bool _hadWiredHeadset = false;
  bool _hadBluetooth = false;

  String? get currentCallId => _currentCallId;
  bool get isBusy => _isBusy;
  bool get callInProgress => _callInProgress;
  CallModel? get activeCall => _activeCall;

  CallCoordinator({
    required CallRepository callRepository,
    required PresenceRepository presenceRepository,
    required RingtoneService ringtoneService,
    required CallNotificationService notificationService,
    required CallPresentationAdapter callKitAdapter,
    required WebRtcService webRtcService,
    FirebaseAuth? firebaseAuth,
  })  : _callRepository = callRepository,
        _presenceRepository = presenceRepository,
        _ringtoneService = ringtoneService,
        _notificationService = notificationService,
        _callKitAdapter = callKitAdapter,
        _webRtcService = webRtcService,
        _auth = firebaseAuth ?? getIt<FirebaseAuth>() {
    _lifecycleManager = CallLifecycleManager(_handleLifecycleStateChanged);
  }

  void initialize() {
    debugPrint('CallCoordinator initialized with repository: $_callRepository');
    _lifecycleManager.startObserving();
    
    // Listen to CallBloc updates
    _blocSubscription?.cancel();
    _blocSubscription = getIt<CallBloc>().stream.listen(_handleCallStateChanged);
    
    // Listen to CallKit events
    _callKitSubscription?.cancel();
    _callKitSubscription = _callKitAdapter.onEvent?.listen(_handleCallKitEvent);

    // Headset and Bluetooth handling
    navigator.mediaDevices.ondevicechange = (event) {
      navigator.mediaDevices.enumerateDevices().then((devices) {
        _checkAudioDeviceChanges(devices);
      }).catchError((e) {
        debugPrint('[AUDIO-SESSION] Error enumerating devices on change: $e');
      });
    };
    navigator.mediaDevices.enumerateDevices().then((devices) {
      _checkAudioDeviceChanges(devices);
    }).catchError((e) {
      debugPrint('[AUDIO-SESSION] Error enumerating initial devices: $e');
    });
  }

  void dispose() {
    _lifecycleManager.stopObserving();
    _blocSubscription?.cancel();
    _callKitSubscription?.cancel();
    _ringtoneService.stop();
  }

  void dumpDiagnostics() {
    debugPrint('[DIAGNOSTICS] --- CallCoordinator Dump ---');
    debugPrint('[DIAGNOSTICS] Current Call ID: $_currentCallId');
    debugPrint('[DIAGNOSTICS] Last Cleaned Call ID: $_lastCleanedCallId');
    debugPrint('[DIAGNOSTICS] Busy Flag (_isBusy): $_isBusy');
    debugPrint('[DIAGNOSTICS] Call In Progress (_callInProgress): $_callInProgress');
    debugPrint('[DIAGNOSTICS] Active Call Model status: ${_activeCall?.status}');
    debugPrint('[DIAGNOSTICS] Local Ready Sent (_localReadySent): $_localReadySent');
    debugPrint('[DIAGNOSTICS] Active Promotion Sent (_activePromotionSent): $_activePromotionSent');
    debugPrint('[DIAGNOSTICS] Auth Subscription active: ${_blocSubscription != null}');
    debugPrint('[DIAGNOSTICS] CallKit Subscription active: ${_callKitSubscription != null}');
    debugPrint('[DIAGNOSTICS] WebRTC State Subscription active: ${_webRtcStateSub != null}');
    debugPrint('[DIAGNOSTICS] Ready States Subscription active: ${_readyStatesSub != null}');
    debugPrint('[DIAGNOSTICS] App Lifecycle State: $_appLifecycleState');
    debugPrint('[DIAGNOSTICS] -------------------------------------');
  }

  void _handleLifecycleStateChanged(AppLifecycleState state) {
    _appLifecycleState = state;
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      debugPrint('[AUDIO-SESSION] App backgrounded');
      if (_callInProgress) {
        debugPrint('[AUDIO-SESSION] Call session preserved');
      }
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('[AUDIO-SESSION] App resumed');
    }
  }

  void _logBusyAudit({
    required String userId,
    required String callId,
    required String operation,
    required String source,
    required bool currentBusy,
  }) {
    final now = DateTime.now().toIso8601String();
    debugPrint('[BUSY-AUDIT]\nuserId=$userId\ncallId=$callId\noperation=$operation\nsource=$source\ncurrentBusy=$currentBusy\ntimestamp=$now');
    debugPrint('[BUSY-AUDIT-STATE] currentCall=$_activeCall activeCallId=$_currentCallId presence_busy=$_isBusy');
  }

  Future<void> _updateBusyState(String userId, String callId, bool newBusy, String source) async {
    final previousBusy = _isBusy;
    _isBusy = newBusy;
    _logBusyAudit(
      userId: userId,
      callId: callId,
      operation: newBusy ? 'SET_BUSY' : 'CLEAR_BUSY',
      source: source,
      currentBusy: newBusy,
    );
    try {
      await _presenceRepository.setUserBusy(userId, newBusy);
    } catch (e) {
      debugPrint('[BUSY-DIAG] Error updating presence busy state in RTDB: $e');
    }
  }

  Future<void> _handleCallStateChanged(CallState state) async {
    final prevStateStr = _previousState?.maybeMap(
      initial: (_) => 'initial',
      calling: (_) => 'calling',
      incomingCall: (_) => 'incomingCall',
      connecting: (_) => 'connecting',
      connected: (_) => 'connected',
      active: (_) => 'active',
      declined: (_) => 'declined',
      missed: (_) => 'missed',
      ended: (_) => 'ended',
      failed: (_) => 'failed',
      orElse: () => 'unknown',
    ) ?? 'none';

    final currentStateStr = state.maybeMap(
      initial: (_) => 'initial',
      calling: (_) => 'calling',
      incomingCall: (_) => 'incomingCall',
      connecting: (_) => 'connecting',
      connected: (_) => 'connected',
      active: (_) => 'active',
      declined: (_) => 'declined',
      missed: (_) => 'missed',
      ended: (_) => 'ended',
      failed: (_) => 'failed',
      orElse: () => 'unknown',
    );

    final callModel = state.maybeMap(
      calling: (s) => s.callModel,
      incomingCall: (s) => s.callModel,
      connecting: (s) => s.callModel,
      connected: (s) => s.callModel,
      active: (s) => s.callModel,
      declined: (s) => s.callModel,
      missed: (s) => s.callModel,
      ended: (s) => s.callModel,
      failed: (s) => s.callModel,
      orElse: () => null,
    );

    if (callModel != null) {
      final currentUserId = _auth.currentUser?.uid;
      final role = callModel.callerId == currentUserId ? 'caller' : 'receiver';
      debugPrint('[CALL-TRACE] callId=${callModel.callId} role=$role $prevStateStr -> $currentStateStr');

      final isTerminal = state.maybeMap(
        declined: (_) => true,
        missed: (_) => true,
        ended: (_) => true,
        failed: (_) => true,
        orElse: () => false,
      );

      // Call Lifecycle Tracing
      if (state.maybeMap(calling: (_) => true, orElse: () => false)) {
        debugPrint('CALL CREATED');
      } else if (state.maybeMap(connected: (_) => true, orElse: () => false)) {
        debugPrint('CALL ACCEPTED');
      } else if (state.maybeMap(connecting: (_) => true, orElse: () => false)) {
        debugPrint('CALL CONNECTING');
      } else if (state.maybeMap(active: (_) => true, orElse: () => false)) {
        debugPrint('CALL ACTIVE');
      } else if (isTerminal) {
        debugPrint('CALL ENDED');
      }

      if (!isTerminal) {
        _currentCallId = callModel.callId;
        _callInProgress = true;
        _activeCall = callModel;

        if (currentUserId != null) {
          await _updateBusyState(currentUserId, callModel.callId, true, '_handleCallStateChanged($currentStateStr)');
        }
      }
    }
    _previousState = state;

    state.maybeMap(
      calling: (s) async {
        final call = s.callModel;
        final currentUserId = _auth.currentUser?.uid;
        if (call.callerId == currentUserId) {
          if (_appLifecycleState == AppLifecycleState.resumed) {
            await _ringtoneService.play(CallAudioType.outgoingDialTone);
          }
        }
      },
      incomingCall: (s) async {
        final call = s.callModel;
        final currentUserId = _auth.currentUser?.uid;
        final isReceiver = call.receiverId == currentUserId;
        
        if (isReceiver) {
          if (_appLifecycleState == AppLifecycleState.resumed) {
            await _ringtoneService.play(CallAudioType.incomingRingtone);
          } else {
            final callerProfile = await _fetchUserProfile(call.callerId);
            final callerName = callerProfile?.displayName ?? callerProfile?.username ?? 'VanishLink User';
            
            await _callKitAdapter.showIncomingCall(
              callId: call.callId,
              callerName: callerName,
              type: call.type == CallType.video ? 'video' : 'voice',
            );
          }
        } else {
          // Caller side: Continue playing dialing tone during ringing status
          if (_appLifecycleState == AppLifecycleState.resumed) {
            await _ringtoneService.play(CallAudioType.outgoingDialTone);
          }
        }
      },
      connecting: (s) async {
        await _ringtoneService.stop();
        debugPrint('[WEBRTC] Call status is now connecting.');
      },
      connected: (s) async {
        await _ringtoneService.stop();
        await _notificationService.showCallEndedNotification(
          callId: s.callModel.callId,
          callerName: '',
          type: s.callModel.type == CallType.video ? 'video' : 'voice',
        );

        final call = s.callModel;
        final currentUserId = _auth.currentUser?.uid;
        
        debugPrint('[WEBRTC] Detects ACCEPTED (connected) status. Starting negotiation for all parties...');
        _startWebRtcNegotiation(call);

        if (call.callerId == currentUserId) {
          debugPrint('[WEBRTC] Caller promoting database call status to connecting...');
          await _callRepository.updateCallStatus(call.callId, 'connecting');
        }
      },
      active: (s) async {
        await _ringtoneService.stop();
      },
      declined: (s) => _cleanupCall(s.callModel),
      missed: (s) => _cleanupCall(s.callModel),
      ended: (s) => _cleanupCall(s.callModel),
      failed: (s) => _cleanupCall(s.callModel, s.message),
      error: (s) {
        debugPrint('[CALL-LIFECYCLE] CallCoordinator received error: ${s.message}');
        _cleanupCall(null, s.message);
      },
      orElse: () {},
    );
  }

  void _startWebRtcNegotiation(CallModel call) {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;

    final peerId = call.callerId == currentUserId ? call.receiverId : call.callerId;

    // Listen to WebRtcService state updates
    _webRtcStateSub?.cancel();
    _webRtcStateSub = _webRtcService.connectionStateStream.listen((state) async {
      debugPrint('[WEBRTC] ConnectionState stream update in CallCoordinator: $state');
      if (state == 'connected') {
        debugPrint('[WEBRTC] PeerConnection connected. Setting local ready status.');
        if (!_localReadySent) {
          _localReadySent = true;
          debugPrint('[WEBRTC] Local peer ready');
          await _callRepository.setReadyStatus(call.callId, currentUserId);
        }
      } else if (state == 'failed') {
        debugPrint('[WEBRTC] PeerConnection failed. Terminating call.');
        await _callRepository.updateCallStatus(call.callId, 'failed');
      }
    });

    // Listen to coordinated readiness status in RTDB
    _readyStatesSub?.cancel();
    _readyStatesSub = _callRepository.watchReadyStatus(call.callId).listen((readyMap) async {
      final localReady = readyMap[currentUserId] != null;
      final remoteReady = readyMap[peerId] != null;
      
      if (localReady && remoteReady) {
        if (!_activePromotionSent) {
          _activePromotionSent = true;
          debugPrint('[WEBRTC] Local peer ready');
          debugPrint('[WEBRTC] Remote peer ready');
          debugPrint('[WEBRTC] Both peers ready');
          if (call.callerId == currentUserId) {
            debugPrint('[WEBRTC] Promoting call to ACTIVE');
            await _callRepository.updateCallStatus(call.callId, 'active');
          }
        } else {
          debugPrint('[CALL-GUARD] Duplicate promotion prevented');
        }
      }
    });

    // Initiate WebRTC connection
    final isCaller = call.callerId == currentUserId;
    _webRtcService.connect(call.callId, currentUserId, peerId, call.type, isCaller);
  }

  Future<void> _cleanupCall(CallModel? call, [String? errorMessage]) async {
    final targetCall = call ?? _activeCall;
    final targetCallId = targetCall?.callId ?? _currentCallId;
    final status = targetCall?.status ?? 'unknown';

    debugPrint('CLEANUP START');
    debugPrint('[CLEANUP-PATH] Triggered by status=$status, errorMessage=$errorMessage');

    if (targetCallId == null || targetCallId == _lastCleanedCallId) {
      debugPrint('[CALL-GUARD] Duplicate cleanup prevented for callId=$targetCallId');
      _isBusy = false;
      _callInProgress = false;
      _activeCall = null;
      _localReadySent = false;
      _activePromotionSent = false;
      debugPrint('CLEANUP COMPLETE');
      return;
    }
    _lastCleanedCallId = targetCallId;
    debugPrint('[CALL-LIFECYCLE] _cleanupCall invoked for callId=$targetCallId');
    _currentCallId = null;

    await _ringtoneService.stop();
    await _callKitAdapter.endCall(targetCallId);

    // Cancel WebRTC subscriptions
    _webRtcStateSub?.cancel();
    _webRtcStateSub = null;
    _readyStatesSub?.cancel();
    _readyStatesSub = null;

    // Dispose local media stream and peer connection
    await _webRtcService.closeConnection(targetCallId);
    await _callRepository.clearReadyStatuses(targetCallId);

    // Reset coordinator memory variables
    _callInProgress = false;
    _activeCall = null;
    _localReadySent = false;
    _activePromotionSent = false;

    // Reset presence busy status via updateBusyState helper
    final currentUserId = _auth.currentUser?.uid;
    debugPrint('CLEAR BUSY');
    if (currentUserId != null) {
      await _updateBusyState(currentUserId, targetCallId, false, '_cleanupCall');
    } else {
      debugPrint('[BUSY-DIAG]\nuserId=null\ncallId=$targetCallId\npreviousBusy=$_isBusy\nnewBusy=false\nsource=_cleanupCall');
      _isBusy = false;
    }

    debugPrint('[CLEANUP] Current call cleared');
    debugPrint('[CLEANUP] Busy flag cleared');
    debugPrint('CLEANUP COMPLETE');

    if (targetCall != null) {
      // Force database call status updates if they are still in a non-terminal state
      try {
        final latestCall = await _callRepository.getCall(targetCall.callId);
        if (latestCall != null) {
          final status = latestCall.status;
          if (status == 'created' || status == 'delivering' || status == 'calling' || status == 'ringing' || status == 'connecting' || status == 'active') {
            final targetStatus = targetCall.status == 'failed' ? 'failed' : 'ended';
            debugPrint('[CLEANUP] Database call status is still $status. Forcing status update to $targetStatus.');
            await _callRepository.updateCallStatus(targetCall.callId, targetStatus);
          }
        }
      } catch (e) {
        debugPrint('[CLEANUP] Error checking/forcing database call status: $e');
      }

      await _notificationService.showCallEndedNotification(
        callId: targetCall.callId,
        callerName: '',
        type: targetCall.type == CallType.video ? 'video' : 'voice',
      );
      
      if (targetCall.status == 'missed') {
        final callerProfile = await _fetchUserProfile(targetCall.callerId);
        final callerName = callerProfile?.displayName ?? callerProfile?.username ?? 'VanishLink User';
        await _notificationService.showMissedCallNotification(
          callId: targetCall.callId,
          callerName: callerName,
          type: targetCall.type == CallType.video ? 'video' : 'voice',
        );
      }
    }
  }

  void _handleCallKitEvent(dynamic event) {
    if (event == null) return;
    if (event is! ck.CallEvent) {
      debugPrint('[CallCoordinator] Ignoring non-CallKit event: $event');
      return;
    }
    switch (event) {
      case ck.CallEventActionCallAccept(:final id):
        getIt<CallBloc>().add(CallEvent.listenToCall(id));
        getIt<CallBloc>().add(CallEvent.acceptCall(callId: id));
        break;
      case ck.CallEventActionCallDecline():
        getIt<CallBloc>().add(const CallEvent.declineCall());
        break;
      case ck.CallEventActionCallTimeout():
        getIt<CallBloc>().add(const CallEvent.declineCall());
        break;
      case ck.CallEventActionCallEnded():
        getIt<CallBloc>().add(const CallEvent.endCall());
        break;
      default:
        break;
    }
  }

  /// Request microphone permission for voice calls
  Future<bool> _requestMicrophonePermission() async {
    final pm = getIt<PermissionManager>();
    final status = await pm.requestPermission(VanishPermissionType.microphone);
    return status == VanishPermissionStatus.granted;
  }

  /// Request camera permission for video calls
  Future<bool> _requestCameraPermission() async {
    final pm = getIt<PermissionManager>();
    final micStatus = await pm.requestPermission(VanishPermissionType.microphone);
    final camStatus = await pm.requestPermission(VanishPermissionType.camera);
    return micStatus == VanishPermissionStatus.granted && camStatus == VanishPermissionStatus.granted;
  }

  /// Initiates a new call with presence validation and permission check.
  Future<void> initiateCall({
    required String callerId,
    required String receiverId,
    required CallType type,
  }) async {
    debugPrint('[CALL-LIFECYCLE] startCall() initiated via CallCoordinator.initiateCall');
    dumpDiagnostics();

    // Self-healing: if currentCallId is non-null but CallBloc.state is terminated, automatically heal coordinator state.
    final callBloc = getIt<CallBloc>();
    final isBlocTerminated = callBloc.state.maybeMap(
      initial: (_) => true,
      error: (_) => true,
      declined: (_) => true,
      missed: (_) => true,
      ended: (_) => true,
      failed: (_) => true,
      orElse: () => false,
    );
    if (isBlocTerminated && (_currentCallId != null || _isBusy || _callInProgress)) {
      debugPrint('[CALL-LIFECYCLE] Self-healing trigger: CallBloc state is terminated but coordinator had active call ID ($_currentCallId) or busy flags. Forcing cleanup.');
      await _cleanupCall(null);
    }

    // 1. Check Busy Handling: Single active call policy
    final hasActive = callBloc.state.maybeMap(
      calling: (_) => true,
      incomingCall: (_) => true,
      connected: (_) => true,
      connecting: (_) => true,
      active: (_) => true,
      orElse: () => false,
    );
    if (hasActive) {
      debugPrint('[CALL-LIFECYCLE] initiateCall aborted: CallBloc already has an active call state.');
      showWarningToast(message: 'You already have an active call.');
      return;
    }

    // 2. Presence check is informational only
    final isOnline = await _isUserOnline(receiverId);
    debugPrint('[CallCoordinator] Receiver presence online status: $isOnline (Initiating call anyway via push delivery model)');

    // 3. Request permissions dynamically
    bool permissionGranted = false;
    if (type == CallType.audio) {
      permissionGranted = await _requestMicrophonePermission();
    } else if (type == CallType.video) {
      permissionGranted = await _requestCameraPermission();
    }
    
    if (!permissionGranted) {
      debugPrint('[CALL-LIFECYCLE] initiateCall aborted: Permissions denied.');
      showErrorToast(message: 'Call permissions denied.');
      return;
    }

    // 4. Dispatch call initiation
    debugPrint('[CALL-LIFECYCLE] initiateCall: Dispatching CreateCall event to CallBloc');
    callBloc.add(CallEvent.createCall(
      callerId: callerId,
      receiverId: receiverId,
      type: type,
    ));
  }

  Future<bool> _isUserOnline(String userId) async {
    try {
      final presence = await _presenceRepository.watchPresence(userId).first.timeout(
        const Duration(seconds: 2),
      );
      return presence.status != PresenceStatusType.offline;
    } catch (_) {
      return false;
    }
  }

  Future<UserProfile?> _fetchUserProfile(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          return UserProfile(
            userId: data['userId'] as String? ?? '',
            vanishId: data['vanishId'] as String? ?? '',
            username: data['username'] as String? ?? '',
            displayName: data['displayName'] as String? ?? '',
            photoUrl: data['photoUrl'] as String? ?? '',
            status: data['status'] as String? ?? '',
          );
        }
      }
    } catch (_) {}
    return null;
  }

  void setMicrophoneMuted(bool muted) {
    _webRtcService.setMicrophoneMuted(muted);
  }

  void toggleCamera(bool enabled) {
    _webRtcService.toggleCamera(enabled);
  }

  Future<void> switchCamera() async {
    await _webRtcService.switchCamera();
  }

  Future<void> setSpeakerphoneOn(bool enabled) async {
    if (kIsWeb) {
      debugPrint('[AUDIO-SESSION] Speaker routing ignored on Web platform.');
      return;
    }
    await _webRtcService.setSpeakerphoneOn(enabled);
  }

  void _checkAudioDeviceChanges(List<MediaDeviceInfo> devices) {
    bool hasWired = false;
    bool hasBluetooth = false;

    for (final device in devices) {
      final label = device.label.toLowerCase();
      if (label.contains('wired') || label.contains('headphone') || label.contains('jack') || label.contains('headset') && !label.contains('bluetooth') && !label.contains('bt')) {
        hasWired = true;
      }
      if (label.contains('bluetooth') || label.contains('bt ') || label.contains('airpods') || label.contains('buds') || label.contains('handsfree')) {
        hasBluetooth = true;
      }
    }

    if (hasWired && !_hadWiredHeadset) {
      debugPrint('[AUDIO-SESSION] Wired headset connected');
    } else if (!hasWired && _hadWiredHeadset) {
      debugPrint('[AUDIO-SESSION] Wired headset disconnected');
    }

    if (hasBluetooth && !_hadBluetooth) {
      debugPrint('[AUDIO-SESSION] Bluetooth route selected');
    } else if (!hasBluetooth && _hadBluetooth) {
      debugPrint('[AUDIO-SESSION] Bluetooth route removed');
    }

    _hadWiredHeadset = hasWired;
    _hadBluetooth = hasBluetooth;
  }
}
