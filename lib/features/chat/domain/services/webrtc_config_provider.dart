abstract class WebRtcConfigProvider {
  Future<Map<String, dynamic>> getConfiguration();
  Future<Map<String, dynamic>> getConstraints();
}

class WebRtcConfigProviderImpl implements WebRtcConfigProvider {
  @override
  Future<Map<String, dynamic>> getConfiguration() async {
    // Return a TURN-ready configuration structure.
    // In the future, this can load dynamically from a backend endpoint or environment variables.
    return {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'stun:stun1.l.google.com:19302'},
        {'urls': 'stun:stun2.l.google.com:19302'},
        // Placeholder for future TURN servers:
        // {
        //   'urls': 'turn:turn.vanishlink.com:3478',
        //   'username': 'placeholder_user',
        //   'credential': 'placeholder_password'
        // }
      ],
      'sdpSemantics': 'unified-plan',
    };
  }

  @override
  Future<Map<String, dynamic>> getConstraints() async {
    return {
      'mandatory': {},
      'optional': [
        {'DtlsSrtpKeyAgreement': true},
      ],
    };
  }
}
