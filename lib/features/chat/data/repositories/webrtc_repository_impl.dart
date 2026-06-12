import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/features/chat/domain/repositories/webrtc_repository.dart';

class WebRtcRepositoryImpl implements WebRtcRepository {
  @override
  Future<RTCPeerConnection> createPeerConnectionInstance() async {
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'stun:stun1.l.google.com:19302'},
        {'urls': 'stun:stun2.l.google.com:19302'},
      ],
      'sdpSemantics': 'unified-plan',
    };

    final Map<String, dynamic> constraints = {
      'mandatory': {},
      'optional': [
        {'DtlsSrtpKeyAgreement': true},
      ],
    };

    return await createPeerConnection(configuration, constraints);
  }

  @override
  Future<RTCSessionDescription> createOffer(RTCPeerConnection pc) async {
    final Map<String, dynamic> constraints = {
      'mandatory': {
        'OfferToReceiveAudio': false,
        'OfferToReceiveVideo': false,
      },
      'optional': [],
    };
    return await pc.createOffer(constraints);
  }

  @override
  Future<RTCSessionDescription> createAnswer(RTCPeerConnection pc) async {
    final Map<String, dynamic> constraints = {
      'mandatory': {
        'OfferToReceiveAudio': false,
        'OfferToReceiveVideo': false,
      },
      'optional': [],
    };
    return await pc.createAnswer(constraints);
  }

  @override
  Future<void> disposeConnection(RTCPeerConnection? pc) async {
    if (pc != null) {
      try {
        await pc.close();
        await pc.dispose();
      } catch (_) {
        // Ignore errors during disposal
      }
    }
  }
}
