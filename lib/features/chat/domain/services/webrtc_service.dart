import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/features/chat/domain/repositories/webrtc_repository.dart';
import 'package:vanish_link/features/chat/domain/repositories/signaling_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';

class WebRtcService {
  final WebRtcRepository _webRtcRepository;
  final SignalingRepository _signalingRepository;

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  StreamSubscription<Map<String, dynamic>>? _signalingSub;
  Timer? _connectionTimeoutTimer;
  Timer? _reconnectTimer;
  Timer? _statsTimer;
  RTCVideoRenderer? _localRenderer;
  RTCVideoRenderer? _remoteRenderer;

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

  RTCVideoRenderer? get localRenderer => _localRenderer;
  RTCVideoRenderer? get remoteRenderer => _remoteRenderer;

  WebRtcService({
    required WebRtcRepository webRtcRepository,
    required SignalingRepository signalingRepository,
  })  : _webRtcRepository = webRtcRepository,
        _signalingRepository = signalingRepository;

  Future<void> initializeRenderers() async {
    debugPrint('[WEBRTC] initializeRenderers() invoked');
    if (_localRenderer == null) {
      _localRenderer = RTCVideoRenderer();
      await _localRenderer!.initialize();
    }
    if (_remoteRenderer == null) {
      _remoteRenderer = RTCVideoRenderer();
      await _remoteRenderer!.initialize();
    }
  }

  Future<void> disposeRenderers() async {
    debugPrint('[WEBRTC] disposeRenderers() invoked');
    if (_localRenderer != null) {
      try {
        _localRenderer!.srcObject = null;
        await _localRenderer!.dispose();
      } catch (e) {
        debugPrint('[WEBRTC] Error disposing local renderer: $e');
      }
      _localRenderer = null;
    }
    if (_remoteRenderer != null) {
      try {
        _remoteRenderer!.srcObject = null;
        await _remoteRenderer!.dispose();
      } catch (e) {
        debugPrint('[WEBRTC] Error disposing remote renderer: $e');
      }
      _remoteRenderer = null;
    }
  }

  /// Starts connection negotiation for caller or receiver role
  Future<void> connect(
    String sessionId,
    String currentUserId,
    String peerUserId, [
    CallType type = CallType.audio,
    bool? isCaller,
  ]) async {
    debugPrint('[WEBRTC] connect() invoked for session: $sessionId, type: $type, isCaller: $isCaller');
    await closeConnection(sessionId);
    await initializeRenderers();

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
        await _initiateAsCaller(sessionId, currentUserId, peerUserId, type);
      } else {
        debugPrint('[WEBRTC] Watching session data to initiate as RECEIVER (Deterministic).');
        _signalingSub = _signalingRepository.watchSession(sessionId).listen((data) async {
          final offerData = data['offer'];
          if (offerData is Map && _peerConnection == null) {
            _signalingSub?.cancel();
            debugPrint('[WEBRTC] Offer detected in signaling channel. Initiating as RECEIVER.');
            await _initiateAsReceiver(sessionId, data, type);
          }
        });
      }
    } else {
      debugPrint('[WEBRTC] connect(): no isCaller provided. Fallback to dynamic role detection.');
      _signalingSub = _signalingRepository.watchSession(sessionId).listen((data) async {
        if (data.isEmpty) {
          _signalingSub?.cancel();
          debugPrint('[WEBRTC] Session data empty. Initiating as CALLER.');
          await _initiateAsCaller(sessionId, currentUserId, peerUserId, type);
        } else {
          final callerId = data['callerId'] as String?;
          if (callerId == null) return;

          _signalingSub?.cancel();
          if (callerId == currentUserId) {
            debugPrint('[WEBRTC] Session data exists. Reconnecting as CALLER.');
            await _reconnectAsCaller(sessionId, data);
          } else {
            debugPrint('[WEBRTC] Session data exists. Initiating as RECEIVER.');
            await _initiateAsReceiver(sessionId, data, type);
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
    CallType type,
  ) async {
    debugPrint('[WEBRTC] [_initiateAsCaller] Creating PeerConnection...');
    _peerConnection = await _webRtcRepository.createPeerConnectionInstance();
    final pc = _peerConnection!;

    _updateState('negotiating');

    pc.onConnectionState = (state) {
      final mapped = _mapConnectionState(state);
      debugPrint('[WEBRTC] ConnectionStateChanged: $mapped');
      debugPrint('[CALL-STATS] Peer Connection State: $mapped');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] Peer connected');
      }
      _updateState(mapped);
    };

    pc.onIceConnectionState = (state) {
      final mapped = _mapIceConnectionState(state);
      debugPrint('[WEBRTC] IceConnectionStateChanged: $mapped');
      final iceStateStr = _mapIceStateString(state);
      debugPrint('[CALL-STATS] ICE State: $iceStateStr');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] ICE connected');
      }
      _updateState(mapped);
    };

    // Obtain local media stream
    final mediaConstraints = {
      'audio': true,
      'video': type == CallType.video ? {
        'facingMode': 'user',
        'width': {'ideal': 640},
        'height': {'ideal': 480},
      } : false,
    };
    if (type == CallType.video) {
      debugPrint('[WEBRTC] camera acquisition');
    }
    debugPrint('[WEBRTC] Accessing media streams with constraints: $mediaConstraints');
    try {
      _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      if (type == CallType.video && _localRenderer != null) {
        _localRenderer!.srcObject = _localStream;
        debugPrint('[WEBRTC] Local video track attached');
      }
      for (final track in _localStream!.getTracks()) {
        await pc.addTrack(track, _localStream!);
        debugPrint('[WEBRTC] Added local track: ${track.id}, kind: ${track.kind}');
      }
      await _setupLocalAudioDiagnostics(pc);
    } catch (e) {
      debugPrint('[WEBRTC] Error acquiring local media stream: $e');
      _updateState('failed');
      return;
    }

    // Handle remote track arrivals
    pc.onTrack = _handleRemoteTrack;

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
    CallType type,
  ) async {
    debugPrint('[WEBRTC] [_initiateAsReceiver] Creating PeerConnection...');
    _peerConnection = await _webRtcRepository.createPeerConnectionInstance();
    final pc = _peerConnection!;

    _updateState('negotiating');

    pc.onConnectionState = (state) {
      final mapped = _mapConnectionState(state);
      debugPrint('[WEBRTC] ConnectionStateChanged: $mapped');
      debugPrint('[CALL-STATS] Peer Connection State: $mapped');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] Peer connected');
      }
      _updateState(mapped);
    };

    pc.onIceConnectionState = (state) {
      final mapped = _mapIceConnectionState(state);
      debugPrint('[WEBRTC] IceConnectionStateChanged: $mapped');
      final iceStateStr = _mapIceStateString(state);
      debugPrint('[CALL-STATS] ICE State: $iceStateStr');
      if (mapped == 'connected') {
        debugPrint('[WEBRTC] ICE connected');
      }
      _updateState(mapped);
    };

    // Obtain local media stream
    final mediaConstraints = {
      'audio': true,
      'video': type == CallType.video ? {
        'facingMode': 'user',
        'width': {'ideal': 640},
        'height': {'ideal': 480},
      } : false,
    };
    if (type == CallType.video) {
      debugPrint('[WEBRTC] camera acquisition');
    }
    debugPrint('[WEBRTC] Accessing media streams with constraints: $mediaConstraints');
    try {
      _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      if (type == CallType.video && _localRenderer != null) {
        _localRenderer!.srcObject = _localStream;
        debugPrint('[WEBRTC] Local video track attached');
      }
      for (final track in _localStream!.getTracks()) {
        await pc.addTrack(track, _localStream!);
        debugPrint('[WEBRTC] Added local track: ${track.id}, kind: ${track.kind}');
      }
      await _setupLocalAudioDiagnostics(pc);
    } catch (e) {
      debugPrint('[WEBRTC] Error acquiring local media stream: $e');
      _updateState('failed');
      return;
    }

    // Handle remote track arrivals
    pc.onTrack = _handleRemoteTrack;

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
    final typeStr = data['type'] as String?;
    final type = typeStr == 'video' ? CallType.video : CallType.audio;
    await _initiateAsCaller(sessionId, data['callerId'], data['receiverId'], type);
  }

  void _updateState(String state) {
    if (state == 'connected') {
      if (_reconnectTimer != null) {
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
        debugPrint('[WEBRTC] Reconnected successfully');
      }
      _rtcConnected = true;
      _checkAndEmitConnected();
      _startStatsMonitoring();
    } else if (state == 'disconnected') {
      debugPrint('[WEBRTC] Connection disconnected');
      _statsTimer?.cancel();
      _statsTimer = null;
      if (_reconnectTimer == null) {
        debugPrint('[WEBRTC] Starting reconnect timer');
        _currentConnectionState = 'reconnecting';
        _connectionStateController.add('reconnecting');
        _reconnectTimer = Timer(const Duration(seconds: 15), () async {
          debugPrint('[WEBRTC] Reconnect timeout expired');
          _reconnectTimer = null;
          _currentConnectionState = 'failed';
          _connectionStateController.add('failed');
        });
      }
    } else if (state == 'failed') {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
      _statsTimer?.cancel();
      _statsTimer = null;
      debugPrint('[WEBRTC] Connection failed');
      _currentConnectionState = 'failed';
      _connectionStateController.add('failed');
    } else if (state == 'closed') {
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
      _statsTimer?.cancel();
      _statsTimer = null;
      _currentConnectionState = 'closed';
      _connectionStateController.add('closed');
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

    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    _statsTimer?.cancel();
    _statsTimer = null;

    await disposeRenderers();

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

    // Reset negotiation metrics and connection status flags
    _candidateCount = 0;
    _offerCreated = false;
    _answerReceived = false;
    _rtcConnected = false;
    _remoteAudioReceived = false;

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

  Future<void> _setupLocalAudioDiagnostics(RTCPeerConnection pc) async {
    if (_localStream != null) {
      for (final track in _localStream!.getTracks()) {
        if (track.kind == 'audio') {
          debugPrint('[AUDIO] Local track enabled: ${track.enabled}');
          debugPrint('[AUDIO] Local track muted: ${track.muted}');
        }
      }
    }
    try {
      final senders = await pc.getSenders();
      debugPrint('[AUDIO] Sender count: ${senders.length}');
      final hasAudioSender = senders.any((s) => s.track?.kind == 'audio');
      debugPrint('[AUDIO] Audio sender attached: $hasAudioSender');
    } catch (e) {
      debugPrint('[AUDIO] Error getting senders: $e');
    }
  }

  Future<void> _handleRemoteTrack(RTCTrackEvent event) async {
    debugPrint('[WEBRTC] onTrack received: streams count: ${event.streams.length}');
    if (event.track.kind == 'audio') {
      event.track.enabled = true;
      _remoteAudioReceived = true;
      debugPrint('[WEBRTC] Remote audio track verified & enabled successfully: ${event.track.id}');
      
      if (kIsWeb) {
        debugPrint('[WEB-AUDIO] Remote stream received');
        try {
          if (_remoteRenderer == null) {
            _remoteRenderer = RTCVideoRenderer();
            await _remoteRenderer!.initialize();
          }
          if (event.streams.isNotEmpty) {
            final remoteStream = event.streams.first;
            _remoteRenderer!.srcObject = remoteStream;
            debugPrint('[WEB-AUDIO] Remote renderer attached');
            debugPrint('[WEB-AUDIO] Playback started');
          } else {
            debugPrint('[WEB-AUDIO] Warning: streams list empty, creating manual MediaStream from track');
            final mediaStream = await navigator.mediaDevices.getUserMedia({'audio': true, 'video': false});
            mediaStream.addTrack(event.track);
            _remoteRenderer!.srcObject = mediaStream;
            debugPrint('[WEB-AUDIO] Remote renderer attached');
            debugPrint('[WEB-AUDIO] Playback started');
          }
        } catch (e) {
          debugPrint('[WEB-AUDIO] Error during playback initialization: $e');
          if (e.toString().contains('autoplay') || e.toString().contains('NotAllowedError')) {
            debugPrint('[WEB-AUDIO] Autoplay blocked / play() failed / User gesture required');
          }
        }
      }
      
      _checkAndEmitConnected();
    } else if (event.track.kind == 'video') {
      event.track.enabled = true;
      debugPrint('[WEBRTC] Remote video track received: ${event.track.id}');
      debugPrint('[WEBRTC] Remote video track received');
      if (event.streams.isNotEmpty && _remoteRenderer != null) {
        _remoteRenderer!.srcObject = event.streams.first;
        debugPrint('[WEBRTC] Remote renderer attached');
      }
    }
  }

  void setMicrophoneMuted(bool muted) {
    if (_localStream != null) {
      for (final track in _localStream!.getAudioTracks()) {
        track.enabled = !muted;
      }
      if (muted) {
        debugPrint('[CALL-CONTROL] Microphone muted');
      } else {
        debugPrint('[CALL-CONTROL] Microphone unmuted');
      }
    }
  }

  void toggleCamera(bool enabled) {
    if (_localStream != null) {
      for (final track in _localStream!.getVideoTracks()) {
        track.enabled = enabled;
      }
      if (enabled) {
        debugPrint('[WEBRTC] Camera enabled');
      } else {
        debugPrint('[WEBRTC] Camera disabled');
      }
    }
  }

  Future<void> switchCamera() async {
    if (_localStream != null) {
      final videoTracks = _localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        try {
          await Helper.switchCamera(videoTracks.first);
          debugPrint('[WEBRTC] Camera switched');
        } catch (e) {
          debugPrint('[WEBRTC] Error switching camera: $e');
        }
      }
    }
  }

  Future<void> setSpeakerphoneOn(bool enabled) async {
    if (kIsWeb) {
      debugPrint('[WEBRTC] setSpeakerphoneOn ignored on Web platform.');
      return;
    }
    try {
      await Helper.setSpeakerphoneOn(enabled);
      if (enabled) {
        debugPrint('[CALL-CONTROL] Speaker enabled');
      } else {
        debugPrint('[CALL-CONTROL] Speaker disabled');
      }
    } catch (e) {
      debugPrint('[CALL-CONTROL] Error setting speakerphone: $e');
    }
  }

  void _startStatsMonitoring() {
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 4), (timer) async {
      if (_peerConnection == null || _currentConnectionState != 'connected') {
        _statsTimer?.cancel();
        _statsTimer = null;
        return;
      }
      try {
        final reports = await _peerConnection!.getStats();
        for (final report in reports) {
          if (report.type == 'candidate-pair' || report.type == 'googCandidatePair') {
            final rtt = report.values['currentRoundTripTime'] ?? report.values['googCurrentRoundTripTime'];
            if (rtt != null) {
              final rttVal = (double.tryParse(rtt.toString()) ?? 0.0) * 1000.0;
              debugPrint('[CALL-STATS] RTT=${rttVal.toStringAsFixed(0)} ms');
            }
          }
          if (report.type == 'inbound-rtp' || report.type == 'inboundrtp') {
            final packetsLost = report.values['packetsLost'];
            final jitter = report.values['jitter'];
            if (packetsLost != null) {
              debugPrint('[CALL-STATS] PacketLoss=$packetsLost%');
            }
            if (jitter != null) {
              debugPrint('[CALL-STATS] Jitter=$jitter');
            }
          }
        }
      } catch (e) {
        debugPrint('[CALL-STATS] Error fetching WebRTC statistics: $e');
      }
    });
  }

  String _mapIceStateString(RTCIceConnectionState state) {
    switch (state) {
      case RTCIceConnectionState.RTCIceConnectionStateNew:
        return 'new';
      case RTCIceConnectionState.RTCIceConnectionStateChecking:
        return 'checking';
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
        return 'connected';
      case RTCIceConnectionState.RTCIceConnectionStateCompleted:
        return 'completed';
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
