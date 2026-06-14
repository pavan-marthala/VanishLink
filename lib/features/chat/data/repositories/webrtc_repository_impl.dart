import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/features/chat/domain/repositories/webrtc_repository.dart';
import 'package:vanish_link/features/chat/domain/services/webrtc_config_provider.dart';

class WebRtcRepositoryImpl implements WebRtcRepository {
  final WebRtcConfigProvider _configProvider;

  WebRtcRepositoryImpl({required WebRtcConfigProvider configProvider})
      : _configProvider = configProvider;

  @override
  Future<RTCPeerConnection> createPeerConnectionInstance() async {
    final configuration = await _configProvider.getConfiguration();
    final constraints = await _configProvider.getConstraints();
    return await createPeerConnection(configuration, constraints);
  }

  @override
  Future<RTCSessionDescription> createOffer(RTCPeerConnection pc) async {
    bool hasVideo = false;
    try {
      final senders = await pc.getSenders();
      final receivers = await pc.getReceivers();
      hasVideo = senders.any((s) => s.track?.kind == 'video') ||
                 receivers.any((r) => r.track?.kind == 'video');
    } catch (_) {}

    final Map<String, dynamic> constraints = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': hasVideo,
      },
      'optional': [],
    };
    return await pc.createOffer(constraints);
  }

  @override
  Future<RTCSessionDescription> createAnswer(RTCPeerConnection pc) async {
    bool hasVideo = false;
    try {
      final senders = await pc.getSenders();
      final receivers = await pc.getReceivers();
      hasVideo = senders.any((s) => s.track?.kind == 'video') ||
                 receivers.any((r) => r.track?.kind == 'video');
    } catch (_) {}

    final Map<String, dynamic> constraints = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': hasVideo,
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
