abstract class SignalingRepository {
  /// Writes the offer data to RTDB signaling node
  Future<void> sendOffer(
    String sessionId,
    String callerId,
    String receiverId,
    Map<String, dynamic> offer,
  );

  /// Writes the answer data to RTDB signaling node
  Future<void> sendAnswer(String sessionId, Map<String, dynamic> answer);

  /// Pushes local ICE candidate to the caller or receiver path in RTDB
  Future<void> sendIceCandidate(
    String sessionId,
    bool isCaller,
    Map<String, dynamic> candidate,
  );

  /// Returns a stream of signaling updates for the given session ID
  Stream<Map<String, dynamic>> watchSession(String sessionId);

  /// Deletes the signaling node completely
  Future<void> deleteSession(String sessionId);

  /// Registers an onDisconnect hook to clear session data on network loss
  Future<void> setupOnDisconnect(String sessionId);
}
