import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/features/chat/domain/repositories/webrtc_repository.dart';
import 'package:vanish_link/features/chat/domain/repositories/signaling_repository.dart';

class WebRtcService {
  final WebRtcRepository _webRtcRepository;
  final SignalingRepository _signalingRepository;

  RTCPeerConnection? _peerConnection;
  RTCDataChannel? _dataChannel;
  StreamSubscription<Map<String, dynamic>>? _signalingSub;

  final _connectionStateController = StreamController<String>.broadcast();
  final _candidateCountController = StreamController<int>.broadcast();
  final _statusUpdateController = StreamController<void>.broadcast();

  int _candidateCount = 0;
  bool _offerCreated = false;
  bool _answerReceived = false;
  String _currentConnectionState = 'new';

  Stream<String> get connectionStateStream => _connectionStateController.stream;
  Stream<int> get candidateCountStream => _candidateCountController.stream;
  Stream<void> get statusUpdateStream => _statusUpdateController.stream;

  int get candidateCount => _candidateCount;
  bool get offerCreated => _offerCreated;
  bool get answerReceived => _answerReceived;
  String get currentConnectionState => _currentConnectionState;

  WebRtcService({
    required WebRtcRepository webRtcRepository,
    required SignalingRepository signalingRepository,
  })  : _webRtcRepository = webRtcRepository,
        _signalingRepository = signalingRepository;

  /// Starts connection negotiation for caller or receiver role
  Future<void> connect(
    String sessionId,
    String currentUserId,
    String peerUserId,
  ) async {
    await closeConnection(sessionId);

    _candidateCount = 0;
    _offerCreated = false;
    _answerReceived = false;
    _currentConnectionState = 'new';

    _connectionStateController.add('new');
    _candidateCountController.add(0);
    _statusUpdateController.add(null);

    // Initial check to determine role
    _signalingSub = _signalingRepository.watchSession(sessionId).listen((data) async {
      if (data.isEmpty) {
        // Session does not exist yet: We are the Caller
        _signalingSub?.cancel();
        await _initiateAsCaller(sessionId, currentUserId, peerUserId);
      } else {
        // Session exists: Check roles
        final callerId = data['callerId'] as String?;
        if (callerId == null) return;

        _signalingSub?.cancel();
        if (callerId == currentUserId) {
          // We are caller reconnecting/recreating
          await _reconnectAsCaller(sessionId, data);
        } else {
          // We are receiver
          await _initiateAsReceiver(sessionId, data);
        }
      }
    });
  }

  Future<void> _initiateAsCaller(
    String sessionId,
    String currentUserId,
    String peerUserId,
  ) async {
    _peerConnection = await _webRtcRepository.createPeerConnectionInstance();
    final pc = _peerConnection!;

    pc.onConnectionState = (state) {
      _currentConnectionState = _mapConnectionState(state);
      _connectionStateController.add(_currentConnectionState);
    };

    pc.onIceConnectionState = (state) {
      _currentConnectionState = _mapIceConnectionState(state);
      _connectionStateController.add(_currentConnectionState);
    };

    // Create a local data channel to trigger candidate gathering
    _dataChannel = await pc.createDataChannel('chat', RTCDataChannelInit());

    // Setup RTDB disconnect hook so server-side deletes session if client drops
    await _signalingRepository.setupOnDisconnect(sessionId);

    // Push local candidate parameters to DB
    pc.onIceCandidate = (candidate) {
      _candidateCount++;
      _candidateCountController.add(_candidateCount);
      _statusUpdateController.add(null);
      _signalingRepository.sendIceCandidate(sessionId, true, {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    // Create and upload SDP offer
    final offer = await _webRtcRepository.createOffer(pc);
    await pc.setLocalDescription(offer);
    _offerCreated = true;
    _statusUpdateController.add(null);

    await _signalingRepository.sendOffer(sessionId, currentUserId, peerUserId, {
      'sdp': offer.sdp,
      'type': offer.type,
    });

    // Listen to signaling changes (receiver answers and candidates)
    _signalingSub = _signalingRepository.watchSession(sessionId).listen((data) async {
      if (data.isEmpty) {
        await closeConnection(sessionId);
        return;
      }

      final answerData = data['answer'];
      if (answerData is Map && !_answerReceived) {
        _answerReceived = true;
        _statusUpdateController.add(null);
        final answer = RTCSessionDescription(
          answerData['sdp'] as String,
          answerData['type'] as String,
        );
        await pc.setRemoteDescription(answer);
      }

      final receiverCandidates = data['receiverCandidates'];
      if (receiverCandidates is Map) {
        for (final entry in receiverCandidates.values) {
          if (entry is Map) {
            final candidate = RTCIceCandidate(
              entry['candidate'] as String,
              entry['sdpMid'] as String?,
              entry['sdpMLineIndex'] as int?,
            );
            await pc.addCandidate(candidate);
          }
        }
      }
    });
  }

  Future<void> _initiateAsReceiver(
    String sessionId,
    Map<String, dynamic> data,
  ) async {
    _peerConnection = await _webRtcRepository.createPeerConnectionInstance();
    final pc = _peerConnection!;

    pc.onConnectionState = (state) {
      _currentConnectionState = _mapConnectionState(state);
      _connectionStateController.add(_currentConnectionState);
    };

    pc.onIceConnectionState = (state) {
      _currentConnectionState = _mapIceConnectionState(state);
      _connectionStateController.add(_currentConnectionState);
    };

    pc.onDataChannel = (channel) {
      _dataChannel = channel;
    };

    // Push local candidate parameters to DB as receiver
    pc.onIceCandidate = (candidate) {
      _candidateCount++;
      _candidateCountController.add(_candidateCount);
      _statusUpdateController.add(null);
      _signalingRepository.sendIceCandidate(sessionId, false, {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    // Set remote description from caller's offer
    final offerData = data['offer'];
    if (offerData is Map) {
      final offer = RTCSessionDescription(
        offerData['sdp'] as String,
        offerData['type'] as String,
      );
      await pc.setRemoteDescription(offer);
    }

    // Create and upload SDP answer
    final answer = await _webRtcRepository.createAnswer(pc);
    await pc.setLocalDescription(answer);

    await _signalingRepository.sendAnswer(sessionId, {
      'sdp': answer.sdp,
      'type': answer.type,
    });

    // Listen to signaling changes (caller candidates)
    _signalingSub = _signalingRepository.watchSession(sessionId).listen((newData) async {
      if (newData.isEmpty) {
        await closeConnection(sessionId);
        return;
      }

      final callerCandidates = newData['callerCandidates'];
      if (callerCandidates is Map) {
        for (final entry in callerCandidates.values) {
          if (entry is Map) {
            final candidate = RTCIceCandidate(
              entry['candidate'] as String,
              entry['sdpMid'] as String?,
              entry['sdpMLineIndex'] as int?,
            );
            await pc.addCandidate(candidate);
          }
        }
      }
    });
  }

  Future<void> _reconnectAsCaller(
    String sessionId,
    Map<String, dynamic> data,
  ) async {
    await _signalingRepository.deleteSession(sessionId);
    await Future.delayed(const Duration(milliseconds: 100));
    await _initiateAsCaller(sessionId, data['callerId'], data['receiverId']);
  }

  /// Closes connection streams and deletes database signaling nodes
  Future<void> closeConnection(String sessionId) async {
    _signalingSub?.cancel();
    _signalingSub = null;

    if (_dataChannel != null) {
      try {
        await _dataChannel!.close();
      } catch (_) {}
      _dataChannel = null;
    }

    if (_peerConnection != null) {
      await _webRtcRepository.disposeConnection(_peerConnection);
      _peerConnection = null;
    }

    _currentConnectionState = 'closed';
    _connectionStateController.add('closed');

    await _signalingRepository.deleteSession(sessionId);
  }

  String _mapConnectionState(RTCPeerConnectionState state) {
    switch (state) {
      case RTCPeerConnectionState.RTCPeerConnectionStateNew:
        return 'new';
      case RTCPeerConnectionState.RTCPeerConnectionStateConnecting:
        return 'connecting';
      case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
        return 'connected';
      case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
        return 'disconnected';
      case RTCPeerConnectionState.RTCPeerConnectionStateFailed:
        return 'failed';
      case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
        return 'closed';
    }
  }

  String _mapIceConnectionState(RTCIceConnectionState state) {
    switch (state) {
      case RTCIceConnectionState.RTCIceConnectionStateNew:
        return 'new';
      case RTCIceConnectionState.RTCIceConnectionStateChecking:
        return 'connecting';
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
      case RTCIceConnectionState.RTCIceConnectionStateCompleted:
        return 'connected';
      case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
        return 'disconnected';
      case RTCIceConnectionState.RTCIceConnectionStateFailed:
        return 'failed';
      case RTCIceConnectionState.RTCIceConnectionStateClosed:
        return 'closed';
      default:
        return 'new';
    }
  }
}
