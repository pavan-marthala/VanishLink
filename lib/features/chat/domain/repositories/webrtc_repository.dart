import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class WebRtcRepository {
  /// Creates a configured RTCPeerConnection instance
  Future<RTCPeerConnection> createPeerConnectionInstance();

  /// Generates a local SDP offer
  Future<RTCSessionDescription> createOffer(RTCPeerConnection pc);

  /// Generates a local SDP answer
  Future<RTCSessionDescription> createAnswer(RTCPeerConnection pc);

  /// Closes and disposes peer connection and local data channels
  Future<void> disposeConnection(RTCPeerConnection? pc);
}
