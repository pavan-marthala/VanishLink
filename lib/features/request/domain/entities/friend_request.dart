import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

class FriendRequest {
  final String requestId;
  final String fromUserId;
  final String toUserId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserProfile? senderProfile;
  final UserProfile? receiverProfile;

  const FriendRequest({
    required this.requestId,
    required this.fromUserId,
    required this.toUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.senderProfile,
    this.receiverProfile,
  });
}
