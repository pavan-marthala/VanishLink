import 'package:vanish_link/features/chat/domain/entities/message.dart';

abstract class MessageRepository {
  /// Sends a text message to a contact.
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String content,
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
}
