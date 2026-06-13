import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
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
  late final CallLifecycleManager _lifecycleManager;
  
  StreamSubscription<CallState>? _blocSubscription;
  StreamSubscription<ck.CallEvent?>? _callKitSubscription;
  StreamSubscription<String>? _webRtcStateSub;
  StreamSubscription<Map<String, dynamic>>? _readyStatesSub;
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;
  CallState? _previousState;

  CallCoordinator({
    required CallRepository callRepository,
    required PresenceRepository presenceRepository,
    required RingtoneService ringtoneService,
    required CallNotificationService notificationService,
    required CallPresentationAdapter callKitAdapter,
    required WebRtcService webRtcService,
  })  : _callRepository = callRepository,
        _presenceRepository = presenceRepository,
        _ringtoneService = ringtoneService,
        _notificationService = notificationService,
        _callKitAdapter = callKitAdapter,
        _webRtcService = webRtcService {
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
  }

  void dispose() {
    _lifecycleManager.stopObserving();
    _blocSubscription?.cancel();
    _callKitSubscription?.cancel();
    _ringtoneService.stop();
  }

  void _handleLifecycleStateChanged(AppLifecycleState state) {
    _appLifecycleState = state;
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
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      final role = callModel.callerId == currentUserId ? 'caller' : 'receiver';
      debugPrint('[CALL-TRACE] callId=${callModel.callId} role=$role $prevStateStr -> $currentStateStr');
    }
    _previousState = state;

    state.maybeMap(
      calling: (s) async {
        final call = s.callModel;
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        if (call.callerId == currentUserId) {
          if (_appLifecycleState == AppLifecycleState.resumed) {
            await _ringtoneService.play(CallAudioType.outgoingDialTone);
          }
        }
      },
      incomingCall: (s) async {
        final call = s.callModel;
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
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
              type: call.type,
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
          type: s.callModel.type,
        );

        final call = s.callModel;
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        
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
      orElse: () {},
    );
  }

  void _startWebRtcNegotiation(CallModel call) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    final peerId = call.callerId == currentUserId ? call.receiverId : call.callerId;

    // Listen to WebRtcService state updates
    _webRtcStateSub?.cancel();
    _webRtcStateSub = _webRtcService.connectionStateStream.listen((state) async {
      debugPrint('[WEBRTC] ConnectionState stream update in CallCoordinator: $state');
      if (state == 'connected') {
        debugPrint('[WEBRTC] PeerConnection connected. Setting local ready status.');
        debugPrint('[WEBRTC] Local peer ready');
        await _callRepository.setReadyStatus(call.callId, currentUserId);
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
      
      if (localReady) {
        debugPrint('[WEBRTC] Local peer ready');
      }
      if (remoteReady) {
        debugPrint('[WEBRTC] Remote peer ready');
      }
      
      if (localReady && remoteReady) {
        debugPrint('[WEBRTC] Both peers ready');
        if (call.callerId == currentUserId) {
          debugPrint('[WEBRTC] Promoting call to ACTIVE');
          await _callRepository.updateCallStatus(call.callId, 'active');
        }
      }
    });

    // Initiate WebRTC connection
    final isCaller = call.callerId == currentUserId;
    _webRtcService.connect(call.callId, currentUserId, peerId, isCaller);
  }

  Future<void> _cleanupCall(CallModel call, [String? errorMessage]) async {
    await _ringtoneService.stop();
    await _callKitAdapter.endCall(call.callId);

    // Cancel WebRTC subscriptions
    _webRtcStateSub?.cancel();
    _webRtcStateSub = null;
    _readyStatesSub?.cancel();
    _readyStatesSub = null;

    // Dispose local media stream and peer connection
    await _webRtcService.closeConnection(call.callId);
    await _callRepository.clearReadyStatuses(call.callId);

    debugPrint('[CLEANUP] Current call cleared');
    debugPrint('[CLEANUP] Busy flag cleared');

    await _notificationService.showCallEndedNotification(
      callId: call.callId,
      callerName: '',
      type: call.type,
    );
    
    if (call.status == 'missed') {
      final callerProfile = await _fetchUserProfile(call.callerId);
      final callerName = callerProfile?.displayName ?? callerProfile?.username ?? 'VanishLink User';
      await _notificationService.showMissedCallNotification(
        callId: call.callId,
        callerName: callerName,
        type: call.type,
      );
    }
  }

  void _handleCallKitEvent(ck.CallEvent? event) {
    if (event == null) return;
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

  /// Initiates a new voice call with presence validation and permission check.
  Future<void> initiateCall({
    required String callerId,
    required String receiverId,
    required String type,
  }) async {
    // 1. Check Busy Handling: Single active call policy
    final callBloc = getIt<CallBloc>();
    final hasActive = callBloc.state.maybeMap(
      calling: (_) => true,
      incomingCall: (_) => true,
      connected: (_) => true,
      connecting: (_) => true,
      active: (_) => true,
      orElse: () => false,
    );
    if (hasActive) {
      showWarningToast(message: 'You already have an active call.');
      return;
    }

    // 2. Presence check is informational only
    final isOnline = await _isUserOnline(receiverId);
    debugPrint('[CallCoordinator] Receiver presence online status: $isOnline (Initiating call anyway via push delivery model)');

    // 3. Request permissions dynamically
    bool permissionGranted = false;
    if (type == 'voice') {
      permissionGranted = await _requestMicrophonePermission();
    } else if (type == 'video') {
      permissionGranted = await _requestCameraPermission();
    }
    
    if (!permissionGranted) {
      showErrorToast(message: 'Call permissions denied.');
      return;
    }

    // 4. Dispatch call initiation
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
}
