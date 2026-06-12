import 'package:firebase_database/firebase_database.dart';
import 'package:vanish_link/features/chat/domain/repositories/signaling_repository.dart';

class SignalingRepositoryImpl implements SignalingRepository {
  final FirebaseDatabase _database;

  SignalingRepositoryImpl({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  @override
  Future<void> sendOffer(
    String sessionId,
    String callerId,
    String receiverId,
    Map<String, dynamic> offer,
  ) async {
    await _database.ref('signaling/$sessionId').update({
      'callerId': callerId,
      'receiverId': receiverId,
      'offer': offer,
      'answer': null,
    });
  }

  @override
  Future<void> sendAnswer(String sessionId, Map<String, dynamic> answer) async {
    await _database.ref('signaling/$sessionId').update({
      'answer': answer,
    });
  }

  @override
  Future<void> sendIceCandidate(
    String sessionId,
    bool isCaller,
    Map<String, dynamic> candidate,
  ) async {
    final candidatePath = isCaller ? 'callerCandidates' : 'receiverCandidates';
    await _database.ref('signaling/$sessionId/$candidatePath').push().set(candidate);
  }

  @override
  Stream<Map<String, dynamic>> watchSession(String sessionId) {
    return _database.ref('signaling/$sessionId').onValue.map((event) {
      final value = event.snapshot.value;
      if (value is Map) {
        return Map<String, dynamic>.from(value.map(
          (k, v) => MapEntry(k.toString(), v),
        ));
      }
      return {};
    });
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    await _database.ref('signaling/$sessionId').remove();
  }

  @override
  Future<void> setupOnDisconnect(String sessionId) async {
    await _database.ref('signaling/$sessionId').onDisconnect().remove();
  }
}
