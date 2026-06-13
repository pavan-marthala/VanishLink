import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/features/chat/domain/repositories/webrtc_repository.dart';
import 'package:vanish_link/features/chat/domain/repositories/signaling_repository.dart';

class WebRtcService {
  final WebRtcRepository _webRtcRepository;
  final SignalingRepository _signalingRepository;

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  StreamSubscription<Map<String, dynamic>>? _signalingSub;
  Timer? _connectionTimeoutTimer;

  final _connectionStateController = StreamController<String>.broadcast();
  final _candidateCountController = StreamController<int>.broadcast();
  final _statusUpdateController = StreamController<void>.broadcast();

  int _candidateCount = 0;
  bool _offerCreated = false;
  bool _answerReceived = false;
  bool _rtcConnected = false;
  bool _remoteAudioReceived = false;
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
    String peerUserId, [
    bool? isCaller,
  ]) async {
    debugPrint('[WEBRTC] connect() invoked for session: $sessionId, isCaller: $isCaller');
    await closeConnection(sessionId);

    _candidateCount = 0;
    _offerCreated = false;
    _answerReceived = false;
    _rtcConnected = false;
    _remoteAudioReceived = false;
    _currentConnectionState = 'new';

    _connectionStateController.add('new');
    _candidateCountController.add(0);
    _statusUpdateController.add(null);

    // Connection Timeout (15 seconds)
    _connectionTimeoutTimer = Timer(const Duration(seconds: 15), () async {
      if (_currentConnectionState != 'connected') {
        debugPrint('[WEBRTC] Connection timeout (15s) expired before reaching connected state.');
        _currentConnectionState = 'failed';
        _connectionStateController.add('failed');
        await closeConnection(sessionId);
      }
    });

    if (isCaller != null) {
      if (isCaller) {
        debugPrint('[WEBRTC] Initiating as CALLER (Deterministic).');
        await _initiateAsCaller(sessionId, currentUserId, peerUserId);
      } else {
        debugPrint('[WEBRTC] Watching session data to initiate as RECEIVER (Deterministic).');
        _signalingSub = _signalingRepository.watchSession(sessionId).listen((data) async {
          final offerData = data['offer'];
          if (offerData is Map && _peerConnection == null) {
            _signalingSub?.cancel();
            debugPrint('[WEBRTC] Offer detected in signaling channel. Initiating as RECEIVER.');
            await _initiateAsReceiver(sessionId, data);
          }
        });
      }
    } else {
      debugPrint('[WEBRTC] connect(): no isCaller provided. Fallback to dynamic role detection.');
      _signalingSub = _signalingRepository.watchSession(sessionId).listen((data) async {
        if (data.isEmpty) {
          _signalingSub?.cancel();
          debugPrint('[WEBRTC] Session data empty. Initiating as CALLER.');
          await _initiateAsCaller(sessionId, currentUserId, peerUserId);
        } else {
          final callerId = data['callerId'] as String?;
          if (callerId == null) return;

          _signalingSub?.cancel();
          if (callerId == currentUserId) {
            debugPrint('[WEBRTC] Session data exists. Reconnecting as CALLER.');
            await _reconnectAsCaller(sessionId, data);
          } else {
            debugPrint('[WEBRTC] Session data exists. Initiating as RECEIVER.');
            await _initiateAsReceiver(sessionId, data);
          }
        }
      });
    }
  }

  /// ICE Restart Placeholder
  Future<void> restartIce(String sessionId) async {
    debugPrint('[WEBRTC] restartIce() invoked for session: $sessionId (Placeholder)');
    if (_peerConnection != null) {
      // Future ICE restart logic
    }
  }

  Future<void> _initiateAsCaller(
    String sessionId,
    String currentUserId,
    String peerUserId,
  ) async {
    debugPrint('[WEBRTC] [_initiateAsCaller] Creating PeerConnection...');
    _peerConnection = await _webRtcRepository.createPeerConnectionInstance();
    final pc = _peerConnection!;

    _updateState('negotiating');

    pc.onConnectionState = (state) {
      final mapped = _mapConnectionState(state);
      debugPrint('[WEBRTC] ConnectionStateChanged: $mapped');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] Peer connected');
      }
      _updateState(mapped);
    };

    pc.onIceConnectionState = (state) {
      final mapped = _mapIceConnectionState(state);
      debugPrint('[WEBRTC] IceConnectionStateChanged: $mapped');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] ICE connected');
      }
      _updateState(mapped);
    };

    // Obtain local audio stream
    debugPrint('[WEBRTC] [_initiateAsCaller] Accessing microphone...');
    try {
      _localStream = await navigator.mediaDevices.getUserMedia({'audio': true, 'video': false});
      _localStream!.getTracks().forEach((track) {
        pc.addTrack(track, _localStream!);
        debugPrint('[WEBRTC] Added local track: ${track.id}, kind: ${track.kind}');
      });
    } catch (e) {
      debugPrint('[WEBRTC] Error acquiring local audio stream: $e');
      _updateState('failed');
      return;
    }

    // Handle remote track arrivals
    pc.onTrack = (event) {
      debugPrint('[WEBRTC] [_initiateAsCaller] onTrack received: streams count: ${event.streams.length}');
      if (event.track.kind == 'audio') {
        event.track.enabled = true;
        _remoteAudioReceived = true;
        debugPrint('[WEBRTC] Remote audio track verified & enabled successfully: ${event.track.id}');
        _checkAndEmitConnected();
      }
    };

    // Setup RTDB disconnect hook so server-side deletes session if client drops
    await _signalingRepository.setupOnDisconnect(sessionId);

    // Push local candidate parameters to DB
    pc.onIceCandidate = (candidate) {
      _candidateCount++;
      _candidateCountController.add(_candidateCount);
      _statusUpdateController.add(null);
      debugPrint('[WEBRTC] Local ICE Candidate generated: ${candidate.candidate}');
      debugPrint('[WEBRTC] ICE candidate generated');
      _signalingRepository.sendIceCandidate(sessionId, true, {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    // Create and upload SDP offer
    debugPrint('[WEBRTC] [_initiateAsCaller] Creating SDP offer...');
    final offer = await _webRtcRepository.createOffer(pc);
    await pc.setLocalDescription(offer);
    _offerCreated = true;
    _statusUpdateController.add(null);
    debugPrint('[WEBRTC] Offer created');

    await _signalingRepository.sendOffer(sessionId, currentUserId, peerUserId, {
      'sdp': offer.sdp,
      'type': offer.type,
    });
    debugPrint('[WEBRTC] Offer uploaded');

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
        debugPrint('[WEBRTC] Receiver SDP answer received.');
        debugPrint('[WEBRTC] Answer received');
        final answer = RTCSessionDescription(
          answerData['sdp'] as String,
          answerData['type'] as String,
        );
        await pc.setRemoteDescription(answer);
        debugPrint('[WEBRTC] Remote description set');
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
            debugPrint('[WEBRTC] Added remote ICE candidate.');
          }
        }
      }
    });
  }

  Future<void> _initiateAsReceiver(
    String sessionId,
    Map<String, dynamic> data,
  ) async {
    debugPrint('[WEBRTC] [_initiateAsReceiver] Creating PeerConnection...');
    _peerConnection = await _webRtcRepository.createPeerConnectionInstance();
    final pc = _peerConnection!;

    _updateState('negotiating');

    pc.onConnectionState = (state) {
      final mapped = _mapConnectionState(state);
      debugPrint('[WEBRTC] ConnectionStateChanged: $mapped');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] Peer connected');
      }
      _updateState(mapped);
    };

    pc.onIceConnectionState = (state) {
      final mapped = _mapIceConnectionState(state);
      debugPrint('[WEBRTC] IceConnectionStateChanged: $mapped');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] ICE connected');
      }
      _updateState(mapped);
    };

    // Obtain local audio stream
    debugPrint('[WEBRTC] [_initiateAsReceiver] Accessing microphone...');
    try {
      _localStream = await navigator.mediaDevices.getUserMedia({'audio': true, 'video': false});
      _localStream!.getTracks().forEach((track) {
        pc.addTrack(track, _localStream!);
        debugPrint('[WEBRTC] Added local track: ${track.id}, kind: ${track.kind}');
      });
    } catch (e) {
      debugPrint('[WEBRTC] Error acquiring local audio stream: $e');
      _updateState('failed');
      return;
    }

    // Handle remote track arrivals
    pc.onTrack = (event) {
      debugPrint('[WEBRTC] [_initiateAsReceiver] onTrack received: streams count: ${event.streams.length}');
      if (event.track.kind == 'audio') {
        event.track.enabled = true;
        _remoteAudioReceived = true;
        debugPrint('[WEBRTC] Remote audio track verified & enabled successfully: ${event.track.id}');
        _checkAndEmitConnected();
      }
    };

    // Push local candidate parameters to DB as receiver
    pc.onIceCandidate = (candidate) {
      _candidateCount++;
      _candidateCountController.add(_candidateCount);
      _statusUpdateController.add(null);
      debugPrint('[WEBRTC] Local ICE Candidate generated (Receiver): ${candidate.candidate}');
      debugPrint('[WEBRTC] ICE candidate generated');
      _signalingRepository.sendIceCandidate(sessionId, false, {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    // Set remote description from caller's offer
    final offerData = data['offer'];
    if (offerData is Map) {
      debugPrint('[WEBRTC] Setting remote SDP offer...');
      debugPrint('[WEBRTC] Offer received');
      final offer = RTCSessionDescription(
        offerData['sdp'] as String,
        offerData['type'] as String,
      );
      await pc.setRemoteDescription(offer);
      debugPrint('[WEBRTC] Remote description set');
    }

    // Create and upload SDP answer
    debugPrint('[WEBRTC] [_initiateAsReceiver] Creating SDP answer...');
    debugPrint('[WEBRTC] Creating answer');
    final answer = await _webRtcRepository.createAnswer(pc);
    await pc.setLocalDescription(answer);

    await _signalingRepository.sendAnswer(sessionId, {
      'sdp': answer.sdp,
      'type': answer.type,
    });
    debugPrint('[WEBRTC] Answer uploaded');

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
            debugPrint('[WEBRTC] Added remote ICE candidate.');
          }
        }
      }
    });
  }

  Future<void> _reconnectAsCaller(
    String sessionId,
    Map<String, dynamic> data,
  ) async {
    debugPrint('[WEBRTC] Reconnecting as caller for session: $sessionId');
    await _signalingRepository.deleteSession(sessionId);
    await Future.delayed(const Duration(milliseconds: 100));
    await _initiateAsCaller(sessionId, data['callerId'], data['receiverId']);
  }

  void _updateState(String state) {
    if (state == 'connected') {
      _rtcConnected = true;
      _checkAndEmitConnected();
    } else {
      _currentConnectionState = state;
      _connectionStateController.add(state);
    }
  }

  void _checkAndEmitConnected() {
    if (_rtcConnected && _remoteAudioReceived) {
      debugPrint('[WEBRTC] Both RTC PeerConnection and remote audio track are validated. Declaring connected.');
      _currentConnectionState = 'connected';
      _connectionStateController.add('connected');
    } else {
      debugPrint('[WEBRTC] _checkAndEmitConnected: _rtcConnected=$_rtcConnected, _remoteAudioReceived=$_remoteAudioReceived');
    }
  }

  /// Closes connection streams and deletes database signaling nodes
  Future<void> closeConnection(String sessionId) async {
    debugPrint('[WEBRTC] closeConnection() for session: $sessionId');
    _signalingSub?.cancel();
    _signalingSub = null;

    _connectionTimeoutTimer?.cancel();
    _connectionTimeoutTimer = null;

    if (_localStream != null) {
      debugPrint('[WEBRTC] Disposing local media stream tracks.');
      _localStream!.getTracks().forEach((track) {
        try {
          track.stop();
        } catch (_) {}
      });
      try {
        await _localStream!.dispose();
      } catch (_) {}
      _localStream = null;
    }

    if (_peerConnection != null) {
      debugPrint('[WEBRTC] Disposing RTCPeerConnection.');
      await _webRtcRepository.disposeConnection(_peerConnection);
      _peerConnection = null;
      debugPrint('[CLEANUP] Peer connection disposed');
    }

    _currentConnectionState = 'closed';
    _connectionStateController.add('closed');

    // Fully clean signaling node on database
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
