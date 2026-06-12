import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/discover/domain/repositories/discover_repository.dart';
import 'package:vanish_link/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:vanish_link/features/discover/presentation/screens/discover_screen.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';

class FakeDiscoverRepository implements DiscoverRepository {
  @override
  Future<List<UserProfile>> searchUsers({required String query}) async => [];
  @override
  Future<UserProfile?> getUserProfile(String userId) async => null;
  @override
  Future<FriendshipStatus> checkFriendshipStatus({required String targetUserId}) async => FriendshipStatus.none;
  @override
  Future<void> sendFriendRequest({required String targetUserId}) async {}
}

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

void main() {
  setUp(() {
    GetIt.instance.reset();
    final discoverRepo = FakeDiscoverRepository();
    final presenceRepo = FakePresenceRepository();
    
    getIt.registerFactory<DiscoverBloc>(() => DiscoverBloc(discoverRepository: discoverRepo));
    getIt.registerFactory<PresenceBloc>(() => PresenceBloc(presenceRepository: presenceRepo));
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('DiscoverScreen renders without throwing ProviderNotFoundException', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const DiscoverScreen(),
      ),
    );

    await tester.pump();
    expect(find.text('Discover'), findsOneWidget);
  });
}
