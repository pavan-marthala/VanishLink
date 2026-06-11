import 'package:flutter_test/flutter_test.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/discover/domain/repositories/discover_repository.dart';
import 'package:vanish_link/features/discover/presentation/bloc/discover_bloc.dart';

class FakeDiscoverRepository implements DiscoverRepository {
  final List<UserProfile> searchResults;
  final UserProfile? userProfile;
  FriendshipStatus friendshipStatus;
  bool sendFriendRequestCalled = false;

  FakeDiscoverRepository({
    this.searchResults = const [],
    this.userProfile,
    this.friendshipStatus = FriendshipStatus.none,
  });

  @override
  Future<List<UserProfile>> searchUsers({
    required String query,
  }) async {
    await Future.delayed(Duration.zero);
    return searchResults;
  }

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    await Future.delayed(Duration.zero);
    return userProfile;
  }

  @override
  Future<FriendshipStatus> checkFriendshipStatus({
    required String targetUserId,
  }) async {
    await Future.delayed(Duration.zero);
    return friendshipStatus;
  }

  @override
  Future<void> sendFriendRequest({
    required String targetUserId,
  }) async {
    await Future.delayed(Duration.zero);
    if (targetUserId == 'self_user') {
      throw Exception('You cannot send a friend request to yourself.');
    }
    sendFriendRequestCalled = true;
    friendshipStatus = FriendshipStatus.pendingSent;
  }
}

void main() {
  group('DiscoverBloc Tests', () {
    late FakeDiscoverRepository fakeRepository;
    late DiscoverBloc discoverBloc;

    final testUser = const UserProfile(
      userId: 'user_1',
      vanishId: 'vanish_ABC123',
      username: 'testuser',
      displayName: 'Test User',
      photoUrl: '',
      status: 'Available',
    );

    setUp(() {
      fakeRepository = FakeDiscoverRepository(
        searchResults: [testUser],
        friendshipStatus: FriendshipStatus.none,
      );
      discoverBloc = DiscoverBloc(discoverRepository: fakeRepository);
    });

    tearDown(() {
      discoverBloc.close();
    });

    test('Initial state is DiscoverState.initial', () {
      expect(discoverBloc.state, const DiscoverState.initial());
    });

    test('SearchQueryChanged to empty emits initial state', () async {
      discoverBloc.add(const DiscoverEvent.searchQueryChanged(''));
      expect(discoverBloc.state, const DiscoverState.initial());
    });

    test('SearchQueryChanged to non-empty schedules search and dispatches SearchStarted with friendship status', () async {
      discoverBloc.add(const DiscoverEvent.searchQueryChanged('test'));
      expect(discoverBloc.state, const DiscoverState.initial()); // Initially still initial before debounce

      // Wait 600ms for debounce timer to fire and complete search
      await Future.delayed(const Duration(milliseconds: 600));

      expect(
        discoverBloc.state,
        DiscoverState.results(
          users: [testUser],
          friendshipStatuses: const {
            'user_1': FriendshipStatus.none,
          },
          sendingRequestUserIds: const {},
          actionErrors: const {},
        ),
      );
    });

    test('SendFriendRequest successfully sends request and updates status to pendingSent', () async {
      // 1. First trigger search to populate results
      discoverBloc.add(const DiscoverEvent.searchQueryChanged('test'));
      await Future.delayed(const Duration(milliseconds: 600));

      // 2. Send friend request
      discoverBloc.add(const DiscoverEvent.sendFriendRequest(targetUserId: 'user_1'));

      // Check for optimistic state: sendingRequestUserIds contains user_1
      await Future.microtask(() {});
      discoverBloc.state.mapOrNull(
        results: (s) {
          expect(s.sendingRequestUserIds.contains('user_1'), isTrue);
        },
      );

      // Wait for async request completion
      await Future.delayed(const Duration(milliseconds: 10));

      expect(fakeRepository.sendFriendRequestCalled, isTrue);

      // We expect action loading to end and status to update to pendingSent
      expect(
        discoverBloc.state,
        DiscoverState.results(
          users: [testUser],
          friendshipStatuses: const {
            'user_1': FriendshipStatus.pendingSent,
          },
          sendingRequestUserIds: const {},
          actionErrors: const {},
        ),
      );
    });

    test('SendFriendRequest to self fails and updates actionErrors', () async {
      final selfUser = const UserProfile(
        userId: 'self_user',
        vanishId: 'vanish_SELF123',
        username: 'selfuser',
        displayName: 'Self User',
        photoUrl: '',
        status: 'Available',
      );

      final selfRepo = FakeDiscoverRepository(
        searchResults: [selfUser],
        friendshipStatus: FriendshipStatus.none,
      );
      final selfBloc = DiscoverBloc(discoverRepository: selfRepo);

      // 1. Populate results
      selfBloc.add(const DiscoverEvent.searchQueryChanged('self'));
      await Future.delayed(const Duration(milliseconds: 600));

      // 2. Send request to self
      selfBloc.add(const DiscoverEvent.sendFriendRequest(targetUserId: 'self_user'));
      await Future.delayed(const Duration(milliseconds: 10));

      selfBloc.state.mapOrNull(
        results: (s) {
          expect(
            s.actionErrors['self_user'],
            'You cannot send a friend request to yourself.',
          );
        },
      );

      selfBloc.close();
    });
  });
}
