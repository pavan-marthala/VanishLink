import 'package:freezed_annotation/freezed_annotation.dart';

part 'webrtc_event.freezed.dart';

@freezed
class WebRtcEvent with _$WebRtcEvent {
  const factory WebRtcEvent.initializeConnection({
    required String sessionId,
    required String currentUserId,
    required String peerUserId,
  }) = InitializeConnection;

  const factory WebRtcEvent.createOffer() = CreateOffer;
  const factory WebRtcEvent.receiveOffer() = ReceiveOffer;
  const factory WebRtcEvent.createAnswer() = CreateAnswer;
  const factory WebRtcEvent.receiveAnswer() = ReceiveAnswer;
  const factory WebRtcEvent.addCandidate() = AddCandidate;

  const factory WebRtcEvent.connectionStateChanged(String state) = ConnectionStateChanged;
  const factory WebRtcEvent.closeConnection() = CloseConnection;
}
