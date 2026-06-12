import 'package:audioplayers/audioplayers.dart';

enum CallAudioType {
  incomingRingtone,
  outgoingDialTone,
}

class RingtoneService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  CallAudioType? _currentType;

  Future<void> play(CallAudioType type) async {
    // If already playing the requested audio type, do nothing.
    // If playing a different audio type, stop first.
    if (_isPlaying) {
      if (_currentType == type) return;
      await stop();
    }
    
    try {
      _isPlaying = true;
      _currentType = type;
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      
      final assetPath = type == CallAudioType.incomingRingtone
          ? 'audio/ringtone.mp3'
          : 'audio/dialing_tone.mp3';
          
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (_) {
      _isPlaying = false;
      _currentType = null;
    }
  }

  Future<void> stop() async {
    if (!_isPlaying) return;
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentType = null;
    } catch (_) {}
  }
}
