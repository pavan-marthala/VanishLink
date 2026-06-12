import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';

part 'call_state.freezed.dart';

@freezed
class CallState with _$CallState {
  const factory CallState.initial() = _Initial;
  const factory CallState.calling(CallModel callModel) = _Calling;
  const factory CallState.incomingCall(CallModel callModel) = _IncomingCall;
  const factory CallState.connected(CallModel callModel) = _Connected;
  const factory CallState.declined(CallModel callModel) = _Declined;
  const factory CallState.missed(CallModel callModel) = _Missed;
  const factory CallState.ended(CallModel callModel) = _Ended;
  const factory CallState.error(String message) = _Error;
}
