import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/chat/domain/services/webrtc_service.dart';
import 'webrtc_event.dart';
import 'webrtc_state.dart';

export 'webrtc_event.dart';
export 'webrtc_state.dart';

class WebRtcBloc extends Bloc<WebRtcEvent, WebRtcState> {
  final WebRtcService _webRtcService;
  StreamSubscription<String>? _connectionStateSub;
  StreamSubscription<int>? _candidateCountSub;
  StreamSubscription<void>? _statusUpdateSub;
  String? _currentSessionId;

  WebRtcBloc({required WebRtcService webRtcService})
      : _webRtcService = webRtcService,
        super(const WebRtcState.initial()) {
    on<InitializeConnection>((event, emit) async {
      _currentSessionId = event.sessionId;
      emit(WebRtcState.connecting(
        sessionId: event.sessionId,
        connectionState: 'new',
        candidateCount: 0,
        offerCreated: false,
        answerReceived: false,
      ));

      _connectionStateSub?.cancel();
      _candidateCountSub?.cancel();
      _statusUpdateSub?.cancel();

      _connectionStateSub = _webRtcService.connectionStateStream.listen((state) {
        add(WebRtcEvent.connectionStateChanged(state));
      });

      _candidateCountSub = _webRtcService.candidateCountStream.listen((count) {
        add(const WebRtcEvent.addCandidate());
      });

      _statusUpdateSub = _webRtcService.statusUpdateStream.listen((_) {
        add(WebRtcEvent.connectionStateChanged(_webRtcService.currentConnectionState));
      });

      try {
        await _webRtcService.connect(
          event.sessionId,
          event.currentUserId,
          event.peerUserId,
        );
      } catch (_) {
        add(const WebRtcEvent.connectionStateChanged('failed'));
      }
    });

    on<ConnectionStateChanged>((event, emit) {
      final sessionId = _currentSessionId ?? '';

      switch (event.state) {
        case 'new':
        case 'connecting':
        case 'negotiating':
        case 'reconnecting':
          emit(WebRtcState.connecting(
            sessionId: sessionId,
            connectionState: event.state,
            candidateCount: _webRtcService.candidateCount,
            offerCreated: _webRtcService.offerCreated,
            answerReceived: _webRtcService.answerReceived,
          ));
          break;
        case 'connected':
          emit(WebRtcState.connected(
            sessionId: sessionId,
            candidateCount: _webRtcService.candidateCount,
          ));
          break;
        case 'disconnected':
          emit(WebRtcState.disconnected(sessionId: sessionId));
          break;
        case 'failed':
          emit(WebRtcState.failed(
            sessionId: sessionId,
            error: 'WebRTC Connection failed or dropped.',
          ));
          break;
        case 'closed':
          emit(const WebRtcState.closed());
          break;
      }
    });

    on<CreateOffer>((event, emit) {
      state.maybeMap(
        connecting: (s) => emit(s.copyWith(offerCreated: true)),
        orElse: () {},
      );
    });

    on<ReceiveOffer>((event, emit) {
      // Receivers track offer progression automatically through service
    });

    on<CreateAnswer>((event, emit) {
      // Receivers track answer progression automatically through service
    });

    on<ReceiveAnswer>((event, emit) {
      state.maybeMap(
        connecting: (s) => emit(s.copyWith(answerReceived: true)),
        orElse: () {},
      );
    });

    on<AddCandidate>((event, emit) {
      state.maybeMap(
        connecting: (s) => emit(s.copyWith(candidateCount: _webRtcService.candidateCount)),
        connected: (s) => emit(s.copyWith(candidateCount: _webRtcService.candidateCount)),
        orElse: () {},
      );
    });

    on<CloseConnection>((event, emit) async {
      final sessionId = _currentSessionId;
      if (sessionId != null) {
        await _webRtcService.closeConnection(sessionId);
      }
      _connectionStateSub?.cancel();
      _candidateCountSub?.cancel();
      _statusUpdateSub?.cancel();
      _currentSessionId = null;
      emit(const WebRtcState.closed());
    });
  }

  @override
  Future<void> close() async {
    _connectionStateSub?.cancel();
    _candidateCountSub?.cancel();
    _statusUpdateSub?.cancel();
    final sessionId = _currentSessionId;
    if (sessionId != null) {
      await _webRtcService.closeConnection(sessionId);
    }
    await super.close();
  }
}
