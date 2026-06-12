import 'package:freezed_annotation/freezed_annotation.dart';

part 'webrtc_state.freezed.dart';

@freezed
class WebRtcState with _$WebRtcState {
  const factory WebRtcState.initial() = Initial;

  const factory WebRtcState.connecting({
    required String sessionId,
    required String connectionState,
    required int candidateCount,
    required bool offerCreated,
    required bool answerReceived,
  }) = Connecting;

  const factory WebRtcState.connected({
    required String sessionId,
    required int candidateCount,
  }) = Connected;

  const factory WebRtcState.disconnected({
    required String sessionId,
  }) = Disconnected;

  const factory WebRtcState.failed({
    required String sessionId,
    required String error,
  }) = Failed;

  const factory WebRtcState.closed() = Closed;
}
