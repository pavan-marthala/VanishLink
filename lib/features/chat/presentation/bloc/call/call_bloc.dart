import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'package:flutter/foundation.dart';
import 'package:vanish_link/features/chat/domain/entities/call_delivery.dart';
import 'package:vanish_link/features/chat/domain/services/call_delivery_contracts.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/core/services/permission_manager.dart';
import 'package:vanish_link/features/chat/domain/services/call_coordinator.dart';
import 'call_event.dart';
import 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository _callRepository;
  StreamSubscription<CallModel?>? _callSubscription;
  Timer? _deliveringTimer;
  Timer? _ringingTimer;
  Timer? _durationTimer;
  int _callDuration = 0;

  CallBloc({required CallRepository callRepository})
      : _callRepository = callRepository,
        super(const CallState.initial()) {
    on<CreateCall>(_onCreateCall);
    on<AcceptCall>(_onAcceptCall);
    on<DeclineCall>(_onDeclineCall);
    on<CancelCall>(_onCancelCall);
    on<EndCall>(_onEndCall);
    on<ListenToCall>(_onListenToCall);
    on<CallUpdated>(_onCallUpdated);
    on<ToggleCamera>(_onToggleCamera);
    on<SwitchCamera>(_onSwitchCamera);
  }

  int get callDuration => _callDuration;

  Future<void> _onCreateCall(CreateCall event, Emitter<CallState> emit) async {
    debugPrint('[CALL-LIFECYCLE] CallBloc: CreateCall event received (callerId=${event.callerId}, receiverId=${event.receiverId})');
    final hasActive = state.maybeMap(
      calling: (_) => true,
      incomingCall: (_) => true,
      connected: (_) => true,
      orElse: () => false,
    );
    if (hasActive) {
      emit(const CallState.error('You already have an active call.'));
      return;
    }
    try {
      _callDuration = 0; // Reset duration on call start
      final call = await _callRepository.createCall(
        callerId: event.callerId,
        receiverId: event.receiverId,
        type: event.type,
      );
      emit(CallState.calling(call));
      add(CallEvent.listenToCall(call.callId));
    } catch (e) {
      emit(CallState.error(e.toString()));
    }
  }

  void _onListenToCall(ListenToCall event, Emitter<CallState> emit) {
    debugPrint('[CALL-LIFECYCLE] CallBloc: ListenToCall event received for callId=${event.callId}');
    _callDuration = 0; // Reset duration on call start
    _callSubscription?.cancel();
    _callSubscription = _callRepository.watchCall(event.callId).listen(
      (dynamic incomingCallData) {
        if (isClosed) return;
        if (incomingCallData != null && incomingCallData is! CallModel) {
          // Guard against raw Firebase payload / JS objects leaking through
          return;
        }
        add(CallEvent.callUpdated(incomingCallData as CallModel?));
      },
      onError: (dynamic error) {
        // Defensive stream exception handling to prevent infinite loops
      },
      cancelOnError: false,
    );
  }

  Future<void> _onCallUpdated(CallUpdated event, Emitter<CallState> emit) async {
    final call = event.callModel;
    if (call == null) {
      debugPrint('[CALL-LIFECYCLE] CallBloc: CallUpdated state mapping: status=null -> initial');
      emit(const CallState.initial());
      return;
    }
    debugPrint('[CALL-LIFECYCLE] CallBloc: CallUpdated state mapping: status=${call.status}');

    switch (call.status) {
      case 'created':
        _startDeliveringTimer(call.callId);
        emit(CallState.calling(call));
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        if (call.callerId == currentUserId) {
          getIt<CallDeliveryNotificationTrigger>().triggerIncomingCallPush(call);
          _callRepository.updateCallStatus(call.callId, 'delivering');
        }
        break;
      case 'delivering':
        _startDeliveringTimer(call.callId);
        emit(CallState.calling(call));
        break;
      case 'calling':
      case 'ringing':
        _deliveringTimer?.cancel();
        _deliveringTimer = null;
        _startRingingTimer(call.callId);
        emit(call.status == 'ringing' ? CallState.incomingCall(call) : CallState.calling(call));
        break;
      case 'connecting':
        _cancelDeliveryTimers();
        emit(CallState.connecting(call));
        break;
      case 'accepted':
        _cancelDeliveryTimers();
        _startDurationTimer();
        emit(CallState.connected(call));
        break;
      case 'active':
        _cancelDeliveryTimers();
        _startDurationTimer();
        emit(CallState.active(call));
        break;
      case 'declined':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.declined(call));
        await _callRepository.storeCallHistory(call);
        break;
      case 'busy':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.failed(call, 'User is busy'));
        await _callRepository.storeCallHistory(call);
        break;
      case 'missed':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.missed(call));
        await _callRepository.storeCallHistory(call);
        getIt<CallDeliveryNotificationTrigger>().triggerMissedCallPush(call);
        break;
      case 'unreachable':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.failed(call, 'User is unreachable'));
        await _callRepository.storeCallHistory(call);
        getIt<CallDeliveryNotificationTrigger>().triggerTimeoutCallPush(call);
        break;
      case 'timeout':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.failed(call, 'Call Timeout'));
        await _callRepository.storeCallHistory(call);
        getIt<CallDeliveryNotificationTrigger>().triggerTimeoutCallPush(call);
        break;
      case 'ended':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.ended(call));
        await _callRepository.storeCallHistory(call);
        break;
      case 'failed':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.failed(call, 'Call Failed'));
        await _callRepository.storeCallHistory(call);
        break;
      case 'cancelled':
        _cancelDeliveryTimers();
        _stopDurationTimer();
        _callSubscription?.cancel();
        _callSubscription = null;
        emit(CallState.ended(call)); // Map cancelled to ended for screen pop
        await _callRepository.storeCallHistory(call);
        break;
    }
  }

  Future<void> _onAcceptCall(AcceptCall event, Emitter<CallState> emit) async {
    final callId = event.callId ?? _getActiveCall()?.callId;
    if (callId == null) return;
    debugPrint('[CALL-LIFECYCLE] CallBloc: AcceptCall event received for callId=$callId');

    final call = _getActiveCall();
    if (call != null) {
      final pm = getIt<PermissionManager>();
      // Request mic permission
      final micStatus = await pm.requestPermission(VanishPermissionType.microphone);

      // If video call, request camera permission too
      bool camGranted = true;
      if (call.type == CallType.video) {
        final camStatus = await pm.requestPermission(VanishPermissionType.camera);
        camGranted = camStatus == VanishPermissionStatus.granted;
      }

      if (micStatus != VanishPermissionStatus.granted || !camGranted) {
        debugPrint('[CallBloc] Accept Call aborted: Microphone or Camera permission denied.');
        await _callRepository.updateCallStatus(callId, 'declined');
        emit(CallState.failed(call, 'Microphone permission denied'));
        return;
      }
      // Immediately transition to connecting state visually
      emit(CallState.connecting(call.copyWith(status: 'connecting')));
    }

    await _callRepository.acceptCall(callId);
  }

  Future<void> _onDeclineCall(DeclineCall event, Emitter<CallState> emit) async {
    final call = _getActiveCall();
    if (call == null) return;
    debugPrint('[CALL-LIFECYCLE] CallBloc: DeclineCall event received for callId=${call.callId}');
    await _callRepository.declineCall(call.callId);
  }

  Future<void> _onCancelCall(CancelCall event, Emitter<CallState> emit) async {
    final call = _getActiveCall();
    if (call == null) return;
    debugPrint('[CALL-LIFECYCLE] CallBloc: CancelCall event received for callId=${call.callId}');
    await _callRepository.cancelCall(call.callId);
  }

  Future<void> _onEndCall(EndCall event, Emitter<CallState> emit) async {
    final call = _getActiveCall();
    if (call == null) return;
    debugPrint('[CALL-LIFECYCLE] CallBloc: EndCall event received for callId=${call.callId}');
    await _callRepository.endCall(call.callId, _callDuration);
  }

  CallModel? _getActiveCall() {
    return state.maybeMap(
      calling: (s) => s.callModel,
      incomingCall: (s) => s.callModel,
      connecting: (s) => s.callModel,
      connected: (s) => s.callModel,
      active: (s) => s.callModel,
      orElse: () => null,
    );
  }

  void _startDeliveringTimer(String callId) {
    if (_deliveringTimer != null) return;
    debugPrint('[CallBloc] Starting delivering timer for call: $callId');
    _deliveringTimer = Timer(CallDeliveryConfig.deliveringTimeout, () async {
      final call = _getActiveCall();
      if (call != null && (call.status == 'created' || call.status == 'delivering')) {
        debugPrint('[CallBloc] Call delivering timed out. Marking unreachable.');
        await _callRepository.updateCallStatus(callId, 'unreachable');
      }
    });
  }

  void _startRingingTimer(String callId) {
    if (_ringingTimer != null) return;
    debugPrint('[CallBloc] Starting ringing timer for call: $callId');
    _ringingTimer = Timer(CallDeliveryConfig.ringingTimeout, () async {
      final call = _getActiveCall();
      if (call != null && (call.status == 'ringing' || call.status == 'calling')) {
        debugPrint('[CallBloc] Call ringing timed out. Marking missed.');
        await _callRepository.updateCallStatus(callId, 'missed');
      }
    });
  }

  void _cancelDeliveryTimers() {
    if (_deliveringTimer != null) {
      _deliveringTimer?.cancel();
      _deliveringTimer = null;
      debugPrint('[TIMER] Delivery timer cancelled');
    }
    if (_ringingTimer != null) {
      _ringingTimer?.cancel();
      _ringingTimer = null;
      debugPrint('[TIMER] Ringing timer cancelled');
    }
  }

  void _startDurationTimer() {
    if (_durationTimer != null) return;
    _callDuration = 0;
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _callDuration++;
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  @override
  Future<void> close() {
    _callSubscription?.cancel();
    _cancelDeliveryTimers();
    _durationTimer?.cancel();
    return super.close();
  }

  void _onToggleCamera(ToggleCamera event, Emitter<CallState> emit) {
    getIt<CallCoordinator>().toggleCamera(event.enabled);
  }

  Future<void> _onSwitchCamera(SwitchCamera event, Emitter<CallState> emit) async {
    await getIt<CallCoordinator>().switchCamera();
  }
}
