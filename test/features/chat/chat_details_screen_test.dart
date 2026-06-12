import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';
import 'package:vanish_link/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';

class FakePresenceRepository implements PresenceRepository {
  @override
  Future<void> goOffline() async {}
  @override
  Future<void> goOnline() async {}
  @override
  Future<void> setUserOnline(String userId, bool online) async {}
  @override
  Future<void> setupOnDisconnect(String userId) async {}
  @override
  Future<void> setUserStatus(String userId, PresenceStatusType status) async {}
  @override
  Stream<PresenceStatus> watchPresence(String userId) => Stream.value(PresenceStatus.offline());
  @override
  Stream<bool> watchConnectionState() => Stream.value(true);
}

class FakeMessageRepository implements MessageRepository {
  final StreamController<List<Message>> _messagesController = StreamController<List<Message>>.broadcast();
  final StreamController<Message?> _lastMessageController = StreamController<Message?>.broadcast();
  final StreamController<List<String>> _typingController = StreamController<List<String>>.broadcast();

  final List<String> sentContents = [];

  void emitMessages(List<Message> messages) {
    _messagesController.add(messages);
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
    sentContents.add(content);
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
  }) async {}

  @override
  Stream<Message?> watchLastMessage(String chatId) {
    return _lastMessageController.stream;
  }

  @override
  Future<void> markChatAsRead({
    required String chatId,
    required String userId,
  }) async {}

  @override
  Future<void> markMessagesAsRead({
    required String chatId,
    required String currentUserId,
  }) async {}

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
  }) async {}

  @override
  Future<void> editMessage({
    required String chatId,
    required String messageId,
    required String newContent,
  }) async {}

  @override
  Future<void> deleteMessageForEveryone({
    required String chatId,
    required String messageId,
  }) async {}

  @override
  Future<void> deleteMessageForMe({
    required String chatId,
    required String messageId,
    required String userId,
  }) async {}

  @override
  Future<void> updateReaction({
    required String chatId,
    required String messageId,
    required String userId,
    required String? reaction,
  }) async {}

  @override
  Future<void> setTypingStatus({
    required String chatId,
    required String userId,
    required bool isTyping,
  }) async {}

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
  late FakePresenceRepository fakePresenceRepository;
  late FakeMessageRepository fakeMessageRepository;
  late FakeFirebaseAuth fakeFirebaseAuth;

  setUp(() {
    GetIt.instance.reset();
    fakePresenceRepository = FakePresenceRepository();
    fakeMessageRepository = FakeMessageRepository();
    fakeFirebaseAuth = FakeFirebaseAuth(currentUser: FakeUser('user_me'));

    getIt.registerLazySingleton<FirebaseAuth>(() => fakeFirebaseAuth);
    getIt.registerLazySingleton<PresenceRepository>(() => fakePresenceRepository);
    getIt.registerLazySingleton<MessageRepository>(() => fakeMessageRepository);

    getIt.registerFactory<PresenceBloc>(() => PresenceBloc(presenceRepository: fakePresenceRepository));
    getIt.registerFactory<MessageBloc>(() => MessageBloc(
      messageRepository: fakeMessageRepository,
      firebaseAuth: fakeFirebaseAuth,
    ));
  });

  tearDown(() {
    fakeMessageRepository.dispose();
    GetIt.instance.reset();
  });

  final contact = const UserProfile(
    userId: 'user_alice',
    vanishId: 'vanish_alice',
    username: 'alice',
    displayName: 'Alice Johnson',
    photoUrl: '',
    status: 'Available',
  );

  testWidgets('ChatDetailsScreen renders premium empty state when there are no messages', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: ChatDetailsScreen(
          chatId: 'user_alice',
          contact: contact,
        ),
      ),
    );

    // Initial state is loading or initial
    await tester.pump();

    // Emit empty list from repository stream
    fakeMessageRepository.emitMessages([]);
    await tester.pump();

    // Verify empty state texts
    expect(find.text('Start a conversation with Alice Johnson'), findsOneWidget);
    expect(find.text('6-Hour Expiration Active'), findsOneWidget);
    expect(
      find.text('All messages in VanishLink disappear\nautomatically 6 hours after they are sent.'),
      findsOneWidget,
    );
  });

  testWidgets('ChatDetailsScreen renders messages with correct left/right alignments', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: ChatDetailsScreen(
          chatId: 'user_alice',
          contact: contact,
        ),
      ),
    );

    await tester.pump();

    // Create a message from Alice (incoming) and one from Me (outgoing)
    final msgAlice = Message(
      messageId: 'msg_1',
      chatId: 'user_alice_user_me',
      senderId: 'user_alice',
      receiverId: 'user_me',
      type: 'text',
      content: 'Hello from Alice',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      expiresAt: DateTime.now().add(const Duration(hours: 5, minutes: 55)),
      status: 'sent',
    );

    final msgMe = Message(
      messageId: 'msg_2',
      chatId: 'user_alice_user_me',
      senderId: 'user_me',
      receiverId: 'user_alice',
      type: 'text',
      content: 'Hello from me',
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 6)),
      status: 'sent',
    );

    fakeMessageRepository.emitMessages([msgAlice, msgMe]);
    await tester.pump();

    // Verify message texts exist
    expect(find.text('Hello from Alice'), findsOneWidget);
    expect(find.text('Hello from me'), findsOneWidget);

    // Verify alignments
    final aliceAlign = tester.widget<Align>(
      find.ancestor(
        of: find.text('Hello from Alice'),
        matching: find.byType(Align),
      ).first,
    );
    expect(aliceAlign.alignment, Alignment.centerLeft);

    final meAlign = tester.widget<Align>(
      find.ancestor(
        of: find.text('Hello from me'),
        matching: find.byType(Align),
      ).first,
    );
    expect(meAlign.alignment, Alignment.centerRight);
  });
}
