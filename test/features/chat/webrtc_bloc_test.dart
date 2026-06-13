import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/features/chat/domain/repositories/webrtc_repository.dart';
import 'package:vanish_link/features/chat/domain/repositories/signaling_repository.dart';
import 'package:vanish_link/features/chat/domain/services/webrtc_service.dart';
import 'package:vanish_link/features/chat/presentation/bloc/webrtc/webrtc_bloc.dart';

class FakeMediaStreamTrack extends Fake implements MediaStreamTrack {
  @override
  String get kind => 'audio';
  @override
  String get id => 'remote_audio_track';
  @override
  set enabled(bool value) {}
  @override
  bool get enabled => true;
}

class FakeMediaStream extends Fake implements MediaStream {
  @override
  String get id => 'remote_stream';
}

class FakeRTCRtpReceiver extends Fake implements RTCRtpReceiver {}
class FakeRTCRtpTransceiver extends Fake implements RTCRtpTransceiver {}

class FakeRTCDataChannel extends Fake implements RTCDataChannel {
  bool closeCalled = false;

  @override
  Future<void> close() async {
    closeCalled = true;
  }
}

class FakeRTCPeerConnection extends Fake implements RTCPeerConnection {
  @override
  Function(RTCPeerConnectionState)? onConnectionState;

  @override
  Function(RTCIceConnectionState)? onIceConnectionState;

  @override
  Function(RTCIceCandidate)? onIceCandidate;

  @override
  Function(RTCDataChannel)? onDataChannel;

  @override
  Function(RTCTrackEvent)? onTrack;

  bool closeCalled = false;
  bool disposeCalled = false;
  RTCSessionDescription? localDescription;
  RTCSessionDescription? remoteDescription;
  final List<RTCIceCandidate> candidatesAdded = [];

  @override
  Future<RTCDataChannel> createDataChannel(String label, RTCDataChannelInit init) async {
    return FakeRTCDataChannel();
  }

  @override
  Future<void> setLocalDescription(RTCSessionDescription description) async {
    localDescription = description;
  }

  @override
  Future<void> setRemoteDescription(RTCSessionDescription description) async {
    remoteDescription = description;
  }

  @override
  Future<void> addCandidate(RTCIceCandidate candidate) async {
    candidatesAdded.add(candidate);
  }

  @override
  Future<void> close() async {
    closeCalled = true;
  }

  @override
  Future<void> dispose() async {
    disposeCalled = true;
  }
}

class FakeWebRtcRepository implements WebRtcRepository {
  bool createPeerConnectionCalled = false;
  bool createOfferCalled = false;
  bool createAnswerCalled = false;
  bool disposeConnectionCalled = false;
  late final FakeRTCPeerConnection fakeConnection;

  FakeWebRtcRepository() {
    fakeConnection = FakeRTCPeerConnection();
  }

  @override
  Future<RTCPeerConnection> createPeerConnectionInstance() async {
    debugPrint('DEBUG: createPeerConnectionInstance entered');
    createPeerConnectionCalled = true;
    return fakeConnection;
  }

  @override
  Future<RTCSessionDescription> createOffer(RTCPeerConnection pc) async {
    debugPrint('DEBUG: createOffer entered');
    createOfferCalled = true;
    return RTCSessionDescription('sdp_offer', 'offer');
  }

  @override
  Future<RTCSessionDescription> createAnswer(RTCPeerConnection pc) async {
    debugPrint('DEBUG: createAnswer entered');
    createAnswerCalled = true;
    return RTCSessionDescription('sdp_answer', 'answer');
  }

  @override
  Future<void> disposeConnection(RTCPeerConnection? pc) async {
    disposeConnectionCalled = true;
    if (pc != null) {
      await pc.close();
      await pc.dispose();
    }
  }
}

class FakeSignalingRepository implements SignalingRepository {
  final StreamController<Map<String, dynamic>> _sessionController = StreamController<Map<String, dynamic>>.broadcast();
  final List<Map<String, dynamic>> sentOffers = [];
  final List<Map<String, dynamic>> sentAnswers = [];
  final List<Map<String, dynamic>> sentIceCandidates = [];
  bool deleteSessionCalled = false;
  bool setupOnDisconnectCalled = false;

  void emitSessionData(Map<String, dynamic> data) {
    _sessionController.add(data);
  }

  @override
  Future<void> sendOffer(
    String sessionId,
    String callerId,
    String receiverId,
    Map<String, dynamic> offer,
  ) async {
    sentOffers.add({
      'sessionId': sessionId,
      'callerId': callerId,
      'receiverId': receiverId,
      'offer': offer,
    });
  }

  @override
  Future<void> sendAnswer(String sessionId, Map<String, dynamic> answer) async {
    sentAnswers.add({
      'sessionId': sessionId,
      'answer': answer,
    });
  }

  @override
  Future<void> sendIceCandidate(
    String sessionId,
    bool isCaller,
    Map<String, dynamic> candidate,
  ) async {
    sentIceCandidates.add({
      'sessionId': sessionId,
      'isCaller': isCaller,
      'candidate': candidate,
    });
  }

  @override
  Stream<Map<String, dynamic>> watchSession(String sessionId) {
    return _sessionController.stream;
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    deleteSessionCalled = true;
  }

  @override
  Future<void> setupOnDisconnect(String sessionId) async {
    setupOnDisconnectCalled = true;
  }

  void dispose() {
    _sessionController.close();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WebRtcBloc Tests', () {
    late FakeWebRtcRepository fakeWebRtcRepository;
    late FakeSignalingRepository fakeSignalingRepository;
    late WebRtcService webRtcService;
    late WebRtcBloc webRtcBloc;

    setUp(() {
      const channel = MethodChannel('FlutterWebRTC.Method');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'initialize') {
          return null;
        }
        if (methodCall.method == 'getUserMedia') {
          return {
            'streamId': 'mock_stream_id',
            'tracks': [
              {
                'id': 'mock_track_id',
                'label': 'mock_track_label',
                'kind': 'audio',
                'enabled': true,
                'muted': false,
              }
            ],
          };
        }
        return null;
      });
      fakeWebRtcRepository = FakeWebRtcRepository();
      fakeSignalingRepository = FakeSignalingRepository();
      webRtcService = WebRtcService(
        webRtcRepository: fakeWebRtcRepository,
        signalingRepository: fakeSignalingRepository,
      );
      webRtcBloc = WebRtcBloc(webRtcService: webRtcService);
    });

    tearDown(() async {
      const channel = MethodChannel('FlutterWebRTC.Method');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
      await webRtcBloc.close();
      fakeSignalingRepository.dispose();
    });

    test('Initial state is WebRtcState.initial()', () {
      expect(webRtcBloc.state, const WebRtcState.initial());
    });

    test('InitializeConnection for new session acts as Caller', () async {
      webRtcBloc.add(const WebRtcEvent.initializeConnection(
        sessionId: 'userA_userB',
        currentUserId: 'userA',
        peerUserId: 'userB',
      ));

      // Wait for watchSession stream listener to activate
      await Future.delayed(const Duration(milliseconds: 20));

      // Emit empty map indicating signaling session does not exist
      fakeSignalingRepository.emitSessionData({});

      // Wait to trigger caller setup
      await Future.delayed(const Duration(milliseconds: 50));

      expect(fakeWebRtcRepository.createPeerConnectionCalled, isTrue);
      expect(fakeWebRtcRepository.createOfferCalled, isTrue);
      expect(fakeSignalingRepository.setupOnDisconnectCalled, isTrue);
      expect(fakeSignalingRepository.sentOffers.length, 1);
      expect(fakeSignalingRepository.sentOffers.first['callerId'], 'userA');

      expect(
        webRtcBloc.state,
        const WebRtcState.connecting(
          sessionId: 'userA_userB',
          connectionState: 'negotiating',
          candidateCount: 0,
          offerCreated: true,
          answerReceived: false,
        ),
      );
    });

    test('InitializeConnection for existing session acts as Receiver', () async {
      webRtcBloc.add(const WebRtcEvent.initializeConnection(
        sessionId: 'userA_userB',
        currentUserId: 'userB',
        peerUserId: 'userA',
      ));

      await Future.delayed(const Duration(milliseconds: 20));

      // Emit existing offer data indicating peer (userA) is the caller
      fakeSignalingRepository.emitSessionData({
        'callerId': 'userA',
        'receiverId': 'userB',
        'offer': {
          'sdp': 'sdp_offer',
          'type': 'offer',
        },
      });

      await Future.delayed(const Duration(milliseconds: 50));

      expect(fakeWebRtcRepository.createPeerConnectionCalled, isTrue);
      expect(fakeWebRtcRepository.createAnswerCalled, isTrue);
      expect(fakeSignalingRepository.sentAnswers.length, 1);

      expect(
        webRtcBloc.state,
        const WebRtcState.connecting(
          sessionId: 'userA_userB',
          connectionState: 'negotiating',
          candidateCount: 0,
          offerCreated: false,
          answerReceived: false,
        ),
      );
    });

    test('ConnectionStateChanged maps correctly in BLoC states', () async {
      webRtcBloc.add(const WebRtcEvent.initializeConnection(
        sessionId: 'userA_userB',
        currentUserId: 'userA',
        peerUserId: 'userB',
      ));
      await Future.delayed(const Duration(milliseconds: 20));
      fakeSignalingRepository.emitSessionData({});
      
      // Wait for peer connection initialization to complete
      await Future.delayed(const Duration(milliseconds: 50));
      
      // Simulate remote audio track event to satisfy Phase 1's validation check
      fakeWebRtcRepository.fakeConnection.onTrack?.call(
        RTCTrackEvent(
          track: FakeMediaStreamTrack(),
          receiver: FakeRTCRtpReceiver(),
          transceiver: FakeRTCRtpTransceiver(),
          streams: [FakeMediaStream()],
        ),
      );
      await Future.delayed(const Duration(milliseconds: 20));

      // Simulate connected state callback on peer connection
      fakeWebRtcRepository.fakeConnection.onConnectionState?.call(
        RTCPeerConnectionState.RTCPeerConnectionStateConnected,
      );
      await Future.delayed(const Duration(milliseconds: 50));

      expect(
        webRtcBloc.state,
        const WebRtcState.connected(
          sessionId: 'userA_userB',
          candidateCount: 0,
        ),
      );
    });

    test('CloseConnection disposes and deletes signaling session', () async {
      webRtcBloc.add(const WebRtcEvent.initializeConnection(
        sessionId: 'userA_userB',
        currentUserId: 'userA',
        peerUserId: 'userB',
      ));
      await Future.delayed(const Duration(milliseconds: 20));
      fakeSignalingRepository.emitSessionData({});
      await Future.delayed(const Duration(milliseconds: 50));

      webRtcBloc.add(const WebRtcEvent.closeConnection());
      await Future.delayed(const Duration(milliseconds: 50));

      expect(fakeWebRtcRepository.fakeConnection.closeCalled, isTrue);
      expect(fakeWebRtcRepository.fakeConnection.disposeCalled, isTrue);
      expect(fakeSignalingRepository.deleteSessionCalled, isTrue);
      expect(webRtcBloc.state, const WebRtcState.closed());
    });
  });
}
