import 'package:vanish_link/features/chat/domain/entities/message.dart';

abstract class MessageRepository {
  /// Sends a text message to a contact.
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String content,
    String? replyToMessageId,
    String? replyToSenderId,
    String? replyToPreview,
  });

  /// Listens to message updates for a given chatId in realtime.
  /// Filters out any expired messages client-side.
  Stream<List<Message>> watchMessages(String chatId);

  /// Updates status of a message.
  Future<void> updateMessageStatus({
    required String chatId,
    required String messageId,
    required String status,
  });

  /// Watches the last non-expired message for a given chatId.
  Stream<Message?> watchLastMessage(String chatId);

  /// Marks all incoming messages in a chat as read.
  Future<void> markMessagesAsRead({
    required String chatId,
    required String currentUserId,
  });

  /// Resets the unread count for a user in a specific chat to 0.
  Future<void> markChatAsRead({
    required String chatId,
    required String userId,
  });

  /// Watches all unread counts for a user across all chats.
  Stream<Map<String, int>> watchAllUnreadCounts(String userId);

  /// Watches the unread count of a specific chat for a user.
  Stream<int> watchUnreadCount({
    required String chatId,
    required String userId,
  });

  /// Retries sending a failed message.
  Future<void> retryMessage({
    required String chatId,
    required Message message,
  });

  /// Edits an existing message.
  Future<void> editMessage({
    required String chatId,
    required String messageId,
    required String newContent,
  });

  /// Deletes a message for everyone (replaces content).
  Future<void> deleteMessageForEveryone({
    required String chatId,
    required String messageId,
  });

  /// Hides a message locally for a specific user.
  Future<void> deleteMessageForMe({
    required String chatId,
    required String messageId,
    required String userId,
  });

  /// Sets or clears a reaction on a message.
  Future<void> updateReaction({
    required String chatId,
    required String messageId,
    required String userId,
    required String? reaction,
  });

  /// Sets the typing status of a user in a specific chat.
  Future<void> setTypingStatus({
    required String chatId,
    required String userId,
    required bool isTyping,
  });

  /// Watches user IDs who are currently typing in a specific chat.
  Stream<List<String>> watchTypingUsers({
    required String chatId,
    required String currentUserId,
  });
}
