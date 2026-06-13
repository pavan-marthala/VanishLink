import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';
import 'package:vanish_link/features/chat/domain/services/notification_dispatcher.dart';
import 'package:vanish_link/core/di/injection.dart';
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
    String? replyToMessageId,
    String? replyToSenderId,
    String? replyToPreview,
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
      replyToMessageId: replyToMessageId,
      replyToSenderId: replyToSenderId,
      replyToPreview: replyToPreview,
    );

    await messageRef.set(message.toMap());

    // Increment unread count for receiver
    await _database
        .ref()
        .child('unreadCounts')
        .child(receiverId)
        .child(chatId)
        .set(ServerValue.increment(1));

    try {
      final payload = NotificationPayload(
        id: messageId,
        type: NotificationType.newMessage,
        title: 'New Message',
        body: content,
        senderId: senderId,
        receiverId: receiverId,
        chatId: chatId,
        createdAt: createdAt,
        data: {
          'chatId': chatId,
          'senderId': senderId,
        },
      );
      debugPrint('[MessageRepositoryImpl] Dispatching chat notification for message: $messageId');
      await getIt<NotificationDispatcher>().dispatch(payload);
    } catch (e) {
      debugPrint('Error dispatching message notification: $e');
    }
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

  @override
  Future<void> markMessagesAsRead({
    required String chatId,
    required String currentUserId,
  }) async {
    final messagesSnapshot = await _database
        .ref()
        .child('messages')
        .child(chatId)
        .get();

    if (!messagesSnapshot.exists) return;

    final data = messagesSnapshot.value as Map<dynamic, dynamic>?;
    if (data == null) return;

    final updates = <String, Object?>{};
    for (final entry in data.entries) {
      final msgKey = entry.key as String;
      final msgMap = Map<dynamic, dynamic>.from(entry.value as Map);
      final receiverId = msgMap['receiverId'] as String? ?? '';
      final status = msgMap['status'] as String? ?? '';

      if (receiverId == currentUserId && status != 'read') {
        updates['messages/$chatId/$msgKey/status'] = 'read';
      }
    }

    if (updates.isNotEmpty) {
      await _database.ref().update(updates);
    }
  }

  @override
  Future<void> markChatAsRead({
    required String chatId,
    required String userId,
  }) async {
    await _database
        .ref()
        .child('unreadCounts')
        .child(userId)
        .child(chatId)
        .set(0);
  }

  @override
  Stream<Map<String, int>> watchAllUnreadCounts(String userId) {
    return _database
        .ref()
        .child('unreadCounts')
        .child(userId)
        .onValue
        .map((event) {
          final data = event.snapshot.value as Map<dynamic, dynamic>?;
          if (data == null) return const {};

          return data.map((key, value) {
            final chatId = key as String;
            final count = (value as num?)?.toInt() ?? 0;
            return MapEntry(chatId, count);
          });
        });
  }

  @override
  Stream<int> watchUnreadCount({
    required String chatId,
    required String userId,
  }) {
    return _database
        .ref()
        .child('unreadCounts')
        .child(userId)
        .child(chatId)
        .onValue
        .map((event) {
          final value = event.snapshot.value;
          return (value as num?)?.toInt() ?? 0;
        });
  }

  @override
  Future<void> retryMessage({
    required String chatId,
    required Message message,
  }) async {
    final now = DateTime.now();
    final updatedMessage = message.copyWith(
      status: 'sent',
      createdAt: now,
      expiresAt: now.add(const Duration(hours: 6)),
    );

    await _database
        .ref()
        .child('messages')
        .child(chatId)
        .child(message.messageId)
        .set(updatedMessage.toMap());

    // Increment unread count for receiver
    await _database
        .ref()
        .child('unreadCounts')
        .child(message.receiverId)
        .child(chatId)
        .set(ServerValue.increment(1));
  }

  @override
  Future<void> editMessage({
    required String chatId,
    required String messageId,
    required String newContent,
  }) async {
    await _database
        .ref()
        .child('messages')
        .child(chatId)
        .child(messageId)
        .update({
          'content': newContent,
          'edited': true,
          'editedAt': DateTime.now().millisecondsSinceEpoch,
        });
  }

  @override
  Future<void> deleteMessageForEveryone({
    required String chatId,
    required String messageId,
  }) async {
    await _database
        .ref()
        .child('messages')
        .child(chatId)
        .child(messageId)
        .update({
          'content': 'This message was deleted.',
          'isDeleted': true,
          'deletedAt': DateTime.now().millisecondsSinceEpoch,
        });
  }

  @override
  Future<void> deleteMessageForMe({
    required String chatId,
    required String messageId,
    required String userId,
  }) async {
    await _database
        .ref()
        .child('messages')
        .child(chatId)
        .child(messageId)
        .child('deletedForUsers')
        .child(userId)
        .set(true);
  }

  @override
  Future<void> updateReaction({
    required String chatId,
    required String messageId,
    required String userId,
    required String? reaction,
  }) async {
    final ref = _database
        .ref()
        .child('messages')
        .child(chatId)
        .child(messageId)
        .child('reactions')
        .child(userId);

    if (reaction == null) {
      await ref.remove();
    } else {
      await ref.set(reaction);
    }
  }

  @override
  Future<void> setTypingStatus({
    required String chatId,
    required String userId,
    required bool isTyping,
  }) async {
    await _database
        .ref()
        .child('typing')
        .child(chatId)
        .child(userId)
        .set({
          'isTyping': isTyping,
          'updatedAt': ServerValue.timestamp,
        });
  }

  @override
  Stream<List<String>> watchTypingUsers({
    required String chatId,
    required String currentUserId,
  }) {
    return _database
        .ref()
        .child('typing')
        .child(chatId)
        .onValue
        .map((event) {
          final data = event.snapshot.value as Map<dynamic, dynamic>?;
          if (data == null) return const [];

          final nowMs = DateTime.now().millisecondsSinceEpoch;
          final typingUsers = <String>[];

          data.forEach((key, val) {
            final userId = key as String;
            if (userId == currentUserId) return;

            if (val is Map) {
              final isTyping = val['isTyping'] as bool? ?? false;
              final updatedAt = val['updatedAt'] as int? ?? 0;

              // Only show as typing if isTyping is true AND updatedAt is within 10 seconds
              if (isTyping && (nowMs - updatedAt).abs() < 10000) {
                typingUsers.add(userId);
              }
            }
          });

          return typingUsers;
        });
  }
}
