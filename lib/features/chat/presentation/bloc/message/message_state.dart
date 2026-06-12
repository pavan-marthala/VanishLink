import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';

part 'message_state.freezed.dart';

@freezed
class MessageState with _$MessageState {
  const factory MessageState.initial() = _Initial;
  const factory MessageState.loading() = _Loading;
  
  const factory MessageState.loaded(
    List<Message> messages, {
    @Default([]) List<String> typingUsers,
  }) = _Loaded;

  const factory MessageState.empty() = _Empty;
  const factory MessageState.error(String message) = _Error;
}
