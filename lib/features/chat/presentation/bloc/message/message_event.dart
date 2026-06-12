import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';

part 'message_event.freezed.dart';

@freezed
class MessageEvent with _$MessageEvent {
  const factory MessageEvent.loadMessages(String chatId) = LoadMessages;
  
  const factory MessageEvent.sendMessage({
    required String content,
    String? replyToMessageId,
    String? replyToSenderId,
    String? replyToPreview,
  }) = SendMessage;

  const factory MessageEvent.messagesUpdated(List<Message> messages) = MessagesUpdated;
  const factory MessageEvent.messageDelivered(String messageId) = MessageDelivered;
  const factory MessageEvent.messageRead(String messageId) = MessageRead;
  const factory MessageEvent.markAsRead() = MarkAsRead;
  const factory MessageEvent.retryMessage(Message message) = RetryMessage;

  const factory MessageEvent.editMessage({
    required String messageId,
    required String newContent,
  }) = EditMessage;

  const factory MessageEvent.deleteMessage({
    required String messageId,
    required bool forEveryone,
  }) = DeleteMessage;

  const factory MessageEvent.updateReaction({
    required String messageId,
    required String? reaction,
  }) = UpdateReaction;

  const factory MessageEvent.setTyping({
    required bool isTyping,
  }) = SetTyping;

  const factory MessageEvent.typingUsersUpdated(List<String> typingUsers) = TypingUsersUpdated;
}
