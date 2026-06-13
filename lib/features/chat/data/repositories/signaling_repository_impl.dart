import 'package:flutter/foundation.dart';
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
    final path = 'signaling/$sessionId';
    debugPrint('[SIGNALLING] sendOffer: starting write at path: $path');
    try {
      final ref = _database.ref(path);
      await ref.update({
        'callerId': callerId,
        'receiverId': receiverId,
        'offer': offer,
        'answer': null,
      });
      debugPrint('[SIGNALLING] sendOffer: write completed successfully at path: $path');

      // Post-write verification
      final snapshot = await ref.child('offer').get();
      if (snapshot.exists) {
        debugPrint('[SIGNALLING] Verification SUCCESS: Offer verified in RTDB at path: ${ref.child('offer').path}');
      } else {
        debugPrint('[SIGNALLING] Verification ERROR: Offer does not exist in RTDB after write at: ${ref.child('offer').path}');
      }
    } catch (e, stack) {
      debugPrint('[SIGNALLING] sendOffer: exception during write at path: $path. Error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<void> sendAnswer(String sessionId, Map<String, dynamic> answer) async {
    final path = 'signaling/$sessionId';
    debugPrint('[SIGNALLING] sendAnswer: starting write at path: $path');
    try {
      final ref = _database.ref(path);
      await ref.update({
        'answer': answer,
      });
      debugPrint('[SIGNALLING] sendAnswer: write completed successfully at path: $path');

      // Post-write verification
      final snapshot = await ref.child('answer').get();
      if (snapshot.exists) {
        debugPrint('[SIGNALLING] Verification SUCCESS: Answer verified in RTDB at path: ${ref.child('answer').path}');
      } else {
        debugPrint('[SIGNALLING] Verification ERROR: Answer does not exist in RTDB after write at: ${ref.child('answer').path}');
      }
    } catch (e, stack) {
      debugPrint('[SIGNALLING] sendAnswer: exception during write at path: $path. Error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<void> sendIceCandidate(
    String sessionId,
    bool isCaller,
    Map<String, dynamic> candidate,
  ) async {
    final candidatePath = isCaller ? 'callerCandidates' : 'receiverCandidates';
    final path = 'signaling/$sessionId/$candidatePath';
    debugPrint('[SIGNALLING] sendIceCandidate: starting write at path: $path');
    try {
      final ref = _database.ref(path).push();
      await ref.set(candidate);
      debugPrint('[SIGNALLING] sendIceCandidate: write completed successfully at path: ${ref.path}');

      // Post-write verification
      final snapshot = await ref.get();
      if (snapshot.exists) {
        debugPrint('[SIGNALLING] Verification SUCCESS: ICE Candidate verified in RTDB at path: ${ref.path}');
      } else {
        debugPrint('[SIGNALLING] Verification ERROR: ICE Candidate does not exist in RTDB after write at: ${ref.path}');
      }
    } catch (e, stack) {
      debugPrint('[SIGNALLING] sendIceCandidate: exception during write at path: $path. Error: $e\n$stack');
      rethrow;
    }
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
    final path = 'signaling/$sessionId';
    debugPrint('[SIGNALLING] deleteSession: starting delete at path: $path');
    try {
      final ref = _database.ref(path);
      await ref.remove();
      debugPrint('[SIGNALLING] deleteSession: deleted successfully at path: $path');

      // Post-write verification
      final snapshot = await ref.get();
      if (!snapshot.exists) {
        debugPrint('[SIGNALLING] Verification SUCCESS: Session node successfully confirmed deleted in RTDB at path: $path');
      } else {
        debugPrint('[SIGNALLING] Verification ERROR: Session node still exists in RTDB after delete attempt at path: $path');
      }
    } catch (e, stack) {
      debugPrint('[SIGNALLING] deleteSession: exception during delete at path: $path. Error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<void> setupOnDisconnect(String sessionId) async {
    final path = 'signaling/$sessionId';
    debugPrint('[SIGNALLING] setupOnDisconnect: starting setup at path: $path');
    try {
      await _database.ref(path).onDisconnect().remove();
      debugPrint('[SIGNALLING] setupOnDisconnect: setup completed successfully at path: $path');
    } catch (e, stack) {
      debugPrint('[SIGNALLING] setupOnDisconnect: exception during setup at path: $path. Error: $e\n$stack');
      rethrow;
    }
  }
}
