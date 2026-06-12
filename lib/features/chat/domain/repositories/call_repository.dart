import 'package:vanish_link/features/chat/domain/entities/call_model.dart';

abstract class CallRepository {
  Future<CallModel> createCall({
    required String callerId,
    required String receiverId,
    required String type,
  });

  Future<void> acceptCall(String callId);
  Future<void> declineCall(String callId);
  Future<void> cancelCall(String callId);
  Future<void> endCall(String callId, int duration);
  Future<void> updateCallStatus(String callId, String status);
  Stream<CallModel?> watchCall(String callId);
  Stream<CallModel?> watchIncomingCalls(String userId);
  Future<void> storeCallHistory(CallModel call);
}
