import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/domain/repositories/chat_repository.dart';
import 'package:vanish_link/features/chat/presentation/bloc/chats_bloc.dart';

class FakeChatRepository implements ChatRepository {
  final StreamController<List<UserProfile>> _contactsController = StreamController<List<UserProfile>>.broadcast();

  void emitContacts(List<UserProfile> contacts) {
    _contactsController.add(contacts);
  }

  @override
  Stream<List<UserProfile>> watchContacts() => _contactsController.stream;

  void dispose() {
    _contactsController.close();
  }
}

void main() {
  group('ChatsBloc Tests', () {
    late FakeChatRepository fakeRepository;
    late ChatsBloc chatsBloc;

    final user1 = const UserProfile(
      userId: 'user_1',
      vanishId: 'vanish_111',
      username: 'alice',
      displayName: 'Alice Johnson',
      photoUrl: '',
      status: 'Available',
    );

    final user2 = const UserProfile(
      userId: 'user_2',
      vanishId: 'vanish_222',
      username: 'bob',
      displayName: 'Bob Smith',
      photoUrl: '',
      status: 'Busy',
    );

    setUp(() {
      fakeRepository = FakeChatRepository();
      chatsBloc = ChatsBloc(chatRepository: fakeRepository);
    });

    tearDown(() {
      chatsBloc.close();
      fakeRepository.dispose();
    });

    test('Initial state is ChatsState.initial()', () {
      expect(chatsBloc.state, const ChatsState.initial());
    });

    test('Started event emits loading state and listens to stream', () async {
      chatsBloc.add(const ChatsEvent.started());
      
      await Future.delayed(const Duration(milliseconds: 10));
      expect(chatsBloc.state, const ChatsState.loading());

      fakeRepository.emitContacts([user1, user2]);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(
        chatsBloc.state,
        ChatsState.loaded(
          allContacts: [user1, user2],
          filteredContacts: [user1, user2],
          searchQuery: '',
        ),
      );
    });

    test('SearchQueryChanged filters loaded contacts by displayName', () async {
      // 1. Get into loaded state
      chatsBloc.add(const ChatsEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitContacts([user1, user2]);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Search for Alice
      chatsBloc.add(const ChatsEvent.searchQueryChanged('alice'));
      await Future.delayed(const Duration(milliseconds: 10));

      expect(
        chatsBloc.state,
        ChatsState.loaded(
          allContacts: [user1, user2],
          filteredContacts: [user1],
          searchQuery: 'alice',
        ),
      );
    });

    test('SearchQueryChanged filters loaded contacts by username', () async {
      // 1. Get into loaded state
      chatsBloc.add(const ChatsEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitContacts([user1, user2]);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Search for bob
      chatsBloc.add(const ChatsEvent.searchQueryChanged('bob'));
      await Future.delayed(const Duration(milliseconds: 10));

      expect(
        chatsBloc.state,
        ChatsState.loaded(
          allContacts: [user1, user2],
          filteredContacts: [user2],
          searchQuery: 'bob',
        ),
      );
    });
  });
}
