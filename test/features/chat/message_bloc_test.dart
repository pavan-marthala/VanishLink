import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';
import 'package:vanish_link/features/chat/presentation/bloc/message/message_bloc.dart';

class FakeMessageRepository implements MessageRepository {
  final StreamController<List<Message>> _messagesController = StreamController<List<Message>>.broadcast();
  final StreamController<Message?> _lastMessageController = StreamController<Message?>.broadcast();
  final StreamController<List<String>> _typingController = StreamController<List<String>>.broadcast();

  final List<Map<String, dynamic>> sentMessages = [];
  final List<Map<String, dynamic>> statusUpdates = [];
  final List<Map<String, dynamic>> readChats = [];
  final List<Map<String, dynamic>> readMessages = [];
  final List<Map<String, dynamic>> retriedMessages = [];
  final List<Map<String, dynamic>> editedMessages = [];
  final List<Map<String, dynamic>> deletedForEveryone = [];
  final List<Map<String, dynamic>> deletedForMe = [];
  final List<Map<String, dynamic>> reactionUpdates = [];
  final List<Map<String, dynamic>> typingUpdates = [];

  void emitMessages(List<Message> messages) {
    _messagesController.add(messages);
  }

  void emitLastMessage(Message? message) {
    _lastMessageController.add(message);
  }

  void emitTypingUsers(List<String> users) {
    _typingController.add(users);
  }

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
    sentMessages.add({
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'replyToMessageId': replyToMessageId,
      'replyToSenderId': replyToSenderId,
      'replyToPreview': replyToPreview,
    });
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    return _messagesController.stream;
  }

  @override
  Future<void> updateMessageStatus({
    required String chatId,
    required String messageId,
    required String status,
  }) async {
    statusUpdates.add({
      'chatId': chatId,
      'messageId': messageId,
      'status': status,
    });
  }

  @override
  Stream<Message?> watchLastMessage(String chatId) {
    return _lastMessageController.stream;
  }

  @override
  Future<void> markChatAsRead({
    required String chatId,
    required String userId,
  }) async {
    readChats.add({'chatId': chatId, 'userId': userId});
  }

  @override
  Future<void> markMessagesAsRead({
    required String chatId,
    required String currentUserId,
  }) async {
    readMessages.add({'chatId': chatId, 'currentUserId': currentUserId});
  }

  @override
  Stream<Map<String, int>> watchAllUnreadCounts(String userId) {
    return Stream.value({});
  }

  @override
  Stream<int> watchUnreadCount({
    required String chatId,
    required String userId,
  }) {
    return Stream.value(0);
  }

  @override
  Future<void> retryMessage({
    required String chatId,
    required Message message,
  }) async {
    retriedMessages.add({'chatId': chatId, 'message': message});
  }

  @override
  Future<void> editMessage({
    required String chatId,
    required String messageId,
    required String newContent,
  }) async {
    editedMessages.add({
      'chatId': chatId,
      'messageId': messageId,
      'newContent': newContent,
    });
  }

  @override
  Future<void> deleteMessageForEveryone({
    required String chatId,
    required String messageId,
  }) async {
    deletedForEveryone.add({
      'chatId': chatId,
      'messageId': messageId,
    });
  }

  @override
  Future<void> deleteMessageForMe({
    required String chatId,
    required String messageId,
    required String userId,
  }) async {
    deletedForMe.add({
      'chatId': chatId,
      'messageId': messageId,
      'userId': userId,
    });
  }

  @override
  Future<void> updateReaction({
    required String chatId,
    required String messageId,
    required String userId,
    required String? reaction,
  }) async {
    reactionUpdates.add({
      'chatId': chatId,
      'messageId': messageId,
      'userId': userId,
      'reaction': reaction,
    });
  }

  @override
  Future<void> setTypingStatus({
    required String chatId,
    required String userId,
    required bool isTyping,
  }) async {
    typingUpdates.add({
      'chatId': chatId,
      'userId': userId,
      'isTyping': isTyping,
    });
  }

  @override
  Stream<List<String>> watchTypingUsers({
    required String chatId,
    required String currentUserId,
  }) {
    return _typingController.stream;
  }

  void dispose() {
    _messagesController.close();
    _lastMessageController.close();
    _typingController.close();
  }
}

class FakeUser extends Fake implements User {
  @override
  final String uid;

  FakeUser(this.uid);
}

class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  final User? _currentUser;

  FakeFirebaseAuth({User? currentUser}) : _currentUser = currentUser;

  @override
  User? get currentUser => _currentUser;
}

void main() {
  group('MessageBloc Tests', () {
    late FakeMessageRepository fakeRepository;
    late FakeFirebaseAuth fakeAuth;
    late MessageBloc messageBloc;

    final currentUser = FakeUser('user_me');

    setUp(() {
      fakeRepository = FakeMessageRepository();
      fakeAuth = FakeFirebaseAuth(currentUser: currentUser);
      messageBloc = MessageBloc(
        messageRepository: fakeRepository,
        firebaseAuth: fakeAuth,
      );
    });

    tearDown(() {
      messageBloc.close();
      fakeRepository.dispose();
    });

    test('Initial state is MessageState.initial()', () {
      expect(messageBloc.state, const MessageState.initial());
    });

    test('LoadMessages emits loading and listens to stream', () async {
      messageBloc.add(const MessageEvent.loadMessages('user_me_user_other'));
      await Future.delayed(Duration.zero);

      expect(messageBloc.state, const MessageState.loading());

      // Emit empty message list
      fakeRepository.emitMessages([]);
      await Future.delayed(Duration.zero);
      expect(messageBloc.state, const MessageState.empty());

      // Emit non-empty message list
      final msg = Message(
        messageId: 'msg_1',
        chatId: 'user_me_user_other',
        senderId: 'user_other',
        receiverId: 'user_me',
        type: 'text',
        content: 'Hello',
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 6)),
        status: 'sent',
      );

      fakeRepository.emitMessages([msg]);
      await Future.delayed(Duration.zero);
      expect(messageBloc.state, MessageState.loaded([msg]));
    });

    test('SendMessage invokes repository sendMessage', () async {
      messageBloc.add(const MessageEvent.loadMessages('user_me_user_other'));
      await Future.delayed(Duration.zero);

      messageBloc.add(const MessageEvent.sendMessage(content: 'Test message'));
      await Future.delayed(Duration.zero);

      expect(fakeRepository.sentMessages.length, 1);
      expect(fakeRepository.sentMessages.first['content'], 'Test message');
      expect(fakeRepository.sentMessages.first['senderId'], 'user_me');
      expect(fakeRepository.sentMessages.first['receiverId'], 'user_other');
    });

    test('No automatic update for outgoing messages', () async {
      messageBloc.add(const MessageEvent.loadMessages('user_me_user_other'));
      await Future.delayed(Duration.zero);

      final msg = Message(
        messageId: 'msg_1',
        chatId: 'user_me_user_other',
        senderId: 'user_me',
        receiverId: 'user_other',
        type: 'text',
        content: 'Hello',
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 6)),
        status: 'sent',
      );

      fakeRepository.emitMessages([msg]);
      await Future.delayed(Duration.zero);

      // Verify no status updates was triggered for sender message
      expect(fakeRepository.statusUpdates, isEmpty);
    });

    test('LoadMessages triggers markChatAsRead and markMessagesAsRead', () async {
      messageBloc.add(const MessageEvent.loadMessages('user_me_user_other'));
      await Future.delayed(Duration.zero);

      expect(fakeRepository.readChats.length, 1);
      expect(fakeRepository.readChats.first['chatId'], 'user_me_user_other');
      expect(fakeRepository.readChats.first['userId'], 'user_me');

      expect(fakeRepository.readMessages.length, 1);
      expect(fakeRepository.readMessages.first['chatId'], 'user_me_user_other');
      expect(fakeRepository.readMessages.first['currentUserId'], 'user_me');
    });

    test('Automatic update of incoming messages to read when chat is open', () async {
      messageBloc.add(const MessageEvent.loadMessages('user_me_user_other'));
      await Future.delayed(Duration.zero);

      final msg = Message(
        messageId: 'msg_1',
        chatId: 'user_me_user_other',
        senderId: 'user_other',
        receiverId: 'user_me',
        type: 'text',
        content: 'Hello',
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 6)),
        status: 'sent',
      );

      fakeRepository.emitMessages([msg]);
      await Future.delayed(Duration.zero);

      expect(fakeRepository.statusUpdates.length, 1);
      expect(fakeRepository.statusUpdates.first['messageId'], 'msg_1');
      expect(fakeRepository.statusUpdates.first['status'], 'read');
    });

    test('RetryMessage invokes repository retryMessage', () async {
      final msg = Message(
        messageId: 'failed_123',
        chatId: 'user_me_user_other',
        senderId: 'user_me',
        receiverId: 'user_other',
        type: 'text',
        content: 'Hello failed',
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 6)),
        status: 'failed',
      );

      messageBloc.add(const MessageEvent.loadMessages('user_me_user_other'));
      await Future.delayed(Duration.zero);

      messageBloc.add(MessageEvent.retryMessage(msg));
      await Future.delayed(Duration.zero);

      expect(fakeRepository.retriedMessages.length, 1);
      expect(fakeRepository.retriedMessages.first['chatId'], 'user_me_user_other');
      expect(fakeRepository.retriedMessages.first['message'].messageId, 'failed_123');
    });
  });
}
