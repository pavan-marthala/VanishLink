import 'package:vanish_link/features/request/domain/entities/friend_request.dart';

abstract class RequestRepository {
  Stream<List<FriendRequest>> watchIncomingRequests();
  Stream<List<FriendRequest>> watchOutgoingRequests();
  Future<void> acceptRequest(String requestId, String fromUserId, String toUserId);
  Future<void> declineRequest(String requestId);
  Future<void> cancelRequest(String requestId);
}
