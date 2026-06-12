import 'package:firebase_database/firebase_database.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final FirebaseDatabase _database;

  MessageRepositoryImpl({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  @override
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    final messageRef = _database.ref().child('messages').child(chatId).push();
    final messageId = messageRef.key!;

    final createdAt = DateTime.now();
    final expiresAt = createdAt.add(const Duration(hours: 6));

    final message = Message(
      messageId: messageId,
      chatId: chatId,
      senderId: senderId,
      receiverId: receiverId,
      type: 'text',
      content: content,
      createdAt: createdAt,
      expiresAt: expiresAt,
      status: 'sent',
    );

    await messageRef.set(message.toMap());
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    return _database
        .ref()
        .child('messages')
        .child(chatId)
        .onValue
        .map((event) {
          final data = event.snapshot.value as Map<dynamic, dynamic>?;
          if (data == null) return const [];

          final now = DateTime.now();
          final messages = data.values
              .map((val) => Message.fromMap(Map<dynamic, dynamic>.from(val as Map)))
              .where((msg) => msg.expiresAt.isAfter(now))
              .toList();

          // Sort messages chronologically by createdAt
          messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return messages;
        });
  }

  @override
  Future<void> updateMessageStatus({
    required String chatId,
    required String messageId,
    required String status,
  }) async {
    await _database
        .ref()
        .child('messages')
        .child(chatId)
        .child(messageId)
        .update({'status': status});
  }

  @override
  Stream<Message?> watchLastMessage(String chatId) {
    return _database
        .ref()
        .child('messages')
        .child(chatId)
        .orderByChild('createdAt')
        .limitToLast(1)
        .onValue
        .map((event) {
          final children = event.snapshot.children;
          if (children.isEmpty) return null;

          final lastChild = children.last;
          final data = lastChild.value as Map<dynamic, dynamic>?;
          if (data == null) return null;

          final msg = Message.fromMap(data);
          if (msg.expiresAt.isBefore(DateTime.now())) {
            return null;
          }
          return msg;
        });
  }
}
