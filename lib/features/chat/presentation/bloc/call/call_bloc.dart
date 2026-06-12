import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'call_event.dart';
import 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository _callRepository;
  StreamSubscription<CallModel?>? _callSubscription;
  Timer? _timeoutTimer;
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
  }

  int get callDuration => _callDuration;

  Future<void> _onCreateCall(CreateCall event, Emitter<CallState> emit) async {
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
    _callSubscription?.cancel();
    _callSubscription = _callRepository.watchCall(event.callId).listen((call) {
      if (isClosed) return;
      add(CallEvent.callUpdated(call));
    });
  }

  Future<void> _onCallUpdated(CallUpdated event, Emitter<CallState> emit) async {
    final call = event.callModel;
    if (call == null) {
      emit(const CallState.initial());
      return;
    }

    switch (call.status) {
      case 'calling':
        _startTimeoutTimer(call.callId);
        emit(CallState.calling(call));
        break;
      case 'ringing':
        _startTimeoutTimer(call.callId);
        emit(CallState.incomingCall(call));
        break;
      case 'connecting':
        emit(CallState.connecting(call));
        break;
      case 'accepted':
        _cancelTimeoutTimer();
        _startDurationTimer();
        emit(CallState.connected(call));
        break;
      case 'active':
        _cancelTimeoutTimer();
        _startDurationTimer();
        emit(CallState.active(call));
        break;
      case 'declined':
        _cancelTimeoutTimer();
        _stopDurationTimer();
        emit(CallState.declined(call));
        await _callRepository.storeCallHistory(call);
        break;
      case 'busy':
        _cancelTimeoutTimer();
        _stopDurationTimer();
        emit(CallState.failed(call, 'User is busy'));
        await _callRepository.storeCallHistory(call);
        break;
      case 'missed':
        _cancelTimeoutTimer();
        _stopDurationTimer();
        emit(CallState.missed(call));
        await _callRepository.storeCallHistory(call);
        break;
      case 'ended':
        _cancelTimeoutTimer();
        _stopDurationTimer();
        emit(CallState.ended(call));
        await _callRepository.storeCallHistory(call);
        break;
      case 'failed':
        _cancelTimeoutTimer();
        _stopDurationTimer();
        emit(CallState.failed(call, 'Call Failed'));
        await _callRepository.storeCallHistory(call);
        break;
      case 'cancelled':
        _cancelTimeoutTimer();
        _stopDurationTimer();
        emit(CallState.ended(call)); // Map cancelled to ended for screen pop
        await _callRepository.storeCallHistory(call);
        break;
    }
  }

  Future<void> _onAcceptCall(AcceptCall event, Emitter<CallState> emit) async {
    final callId = event.callId ?? _getActiveCall()?.callId;
    if (callId == null) return;
    await _callRepository.acceptCall(callId);
  }

  Future<void> _onDeclineCall(DeclineCall event, Emitter<CallState> emit) async {
    final call = _getActiveCall();
    if (call == null) return;
    await _callRepository.declineCall(call.callId);
  }

  Future<void> _onCancelCall(CancelCall event, Emitter<CallState> emit) async {
    final call = _getActiveCall();
    if (call == null) return;
    await _callRepository.cancelCall(call.callId);
  }

  Future<void> _onEndCall(EndCall event, Emitter<CallState> emit) async {
    final call = _getActiveCall();
    if (call == null) return;
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

  void _startTimeoutTimer(String callId) {
    if (_timeoutTimer != null) return;
    _timeoutTimer = Timer(const Duration(seconds: 30), () async {
      final call = _getActiveCall();
      if (call != null && (call.status == 'calling' || call.status == 'ringing')) {
        await _callRepository.updateCallStatus(callId, 'missed');
      }
    });
  }

  void _cancelTimeoutTimer() {
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
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
    _timeoutTimer?.cancel();
    _durationTimer?.cancel();
    return super.close();
  }
}
