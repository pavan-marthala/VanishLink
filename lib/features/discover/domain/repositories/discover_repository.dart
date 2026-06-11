import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

enum FriendshipStatus {
  none,
  pendingSent,
  pendingReceived,
  contacts,
}

abstract class DiscoverRepository {
  Future<List<UserProfile>> searchUsers({
    required String query,
  });

  Future<UserProfile?> getUserProfile(String userId);

  Future<FriendshipStatus> checkFriendshipStatus({
    required String targetUserId,
  });

  Future<void> sendFriendRequest({
    required String targetUserId,
  });
}
