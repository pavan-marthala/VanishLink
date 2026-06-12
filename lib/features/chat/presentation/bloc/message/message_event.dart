import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';

part 'message_event.freezed.dart';

@freezed
class MessageEvent with _$MessageEvent {
  const factory MessageEvent.loadMessages(String chatId) = LoadMessages;
  const factory MessageEvent.sendMessage({required String content}) = SendMessage;
  const factory MessageEvent.messagesUpdated(List<Message> messages) = MessagesUpdated;
  const factory MessageEvent.messageDelivered(String messageId) = MessageDelivered;
  const factory MessageEvent.messageRead(String messageId) = MessageRead;
}
