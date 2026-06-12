import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';

part 'call_event.freezed.dart';

@freezed
class CallEvent with _$CallEvent {
  const factory CallEvent.createCall({
    required String callerId,
    required String receiverId,
    required String type,
  }) = CreateCall;

  const factory CallEvent.acceptCall() = AcceptCall;
  const factory CallEvent.declineCall() = DeclineCall;
  const factory CallEvent.cancelCall() = CancelCall;
  const factory CallEvent.endCall() = EndCall;
  const factory CallEvent.listenToCall(String callId) = ListenToCall;
  const factory CallEvent.callUpdated(CallModel? callModel) = CallUpdated;
}
