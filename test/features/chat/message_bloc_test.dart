import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';
import 'package:vanish_link/features/chat/presentation/bloc/message/message_bloc.dart';

class FakeMessageRepository implements MessageRepository {
  final StreamController<List<Message>> _messagesController = StreamController<List<Message>>.broadcast();
  final StreamController<Message?> _lastMessageController = StreamController<Message?>.broadcast();

  final List<Map<String, dynamic>> sentMessages = [];
  final List<Map<String, dynamic>> statusUpdates = [];

  void emitMessages(List<Message> messages) {
    _messagesController.add(messages);
  }

  void emitLastMessage(Message? message) {
    _lastMessageController.add(message);
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    sentMessages.add({
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
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

  void dispose() {
    _messagesController.close();
    _lastMessageController.close();
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

    test('Automatic delivery receipt update when receiving new sent messages', () async {
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

      // Verify repository was called to update status of msg_1 to 'delivered'
      expect(fakeRepository.statusUpdates.length, 1);
      expect(fakeRepository.statusUpdates.first['messageId'], 'msg_1');
      expect(fakeRepository.statusUpdates.first['status'], 'delivered');
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
  });
}
