import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';
import 'package:vanish_link/core/utils/map_parser.dart';
import 'package:flutter/foundation.dart';

class CallRepositoryImpl implements CallRepository {
  final FirebaseDatabase _database;
  final FirebaseFirestore _firestore;

  CallRepositoryImpl({
    FirebaseDatabase? database,
    FirebaseFirestore? firestore,
  })  : _database = database ?? FirebaseDatabase.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<CallModel> createCall({
    required String callerId,
    required String receiverId,
    required String type,
  }) async {
    final ref = _database.ref('calls').push();
    final callId = ref.key!;
    final now = DateTime.now().millisecondsSinceEpoch;

    final call = CallModel(
      callId: callId,
      callerId: callerId,
      receiverId: receiverId,
      type: type,
      status: 'created',
      createdAt: now,
    );

    await ref.set(call.toJson());
    return call;
  }

  @override
  Future<void> acceptCall(String callId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.ref('calls/$callId').update({
      'status': 'accepted',
      'acceptedAt': now,
    });
  }

  @override
  Future<void> declineCall(String callId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.ref('calls/$callId').update({
      'status': 'declined',
      'endedAt': now,
    });
  }

  @override
  Future<void> cancelCall(String callId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.ref('calls/$callId').update({
      'status': 'cancelled',
      'endedAt': now,
    });
  }

  @override
  Future<void> endCall(String callId, int duration) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.ref('calls/$callId').update({
      'status': 'ended',
      'endedAt': now,
      'duration': duration,
    });
  }

  @override
  Future<void> updateCallStatus(String callId, String status) async {
    await _database.ref('calls/$callId').update({
      'status': status,
    });
  }

  @override
  Stream<CallModel?> watchCall(String callId) {
    if (callId.isEmpty) return Stream.value(null);
    return _database.ref('calls/$callId').onValue.map((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists || snapshot.value == null) return null;
      try {
        final map = safeMapCast(snapshot.value);
        if (map == null) return null;
        return CallModel.fromJson(map);
      } catch (_) {
        return null;
      }
    });
  }

  @override
  Stream<CallModel?> watchIncomingCalls(String userId) {
    if (userId.isEmpty) return Stream.value(null);
    return _database
        .ref('calls')
        .orderByChild('receiverId')
        .equalTo(userId)
        .onValue
        .map((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists || snapshot.value == null) return null;
      try {
        final value = snapshot.value;
        if (value is Map) {
          final map = Map<dynamic, dynamic>.from(value);
          for (final entry in map.values) {
            final callMap = safeMapCast(entry);
            if (callMap != null) {
              final status = callMap['status'] as String? ?? '';
              if (status == 'created' || status == 'delivering' || status == 'calling' || status == 'ringing') {
                return CallModel.fromJson(callMap);
              }
            }
          }
        } else if (kIsWeb && value != null) {
          final parentMap = safeMapCast(value);
          if (parentMap != null) {
            for (final entry in parentMap.values) {
               final callMap = safeMapCast(entry);
               if (callMap != null) {
                 final status = callMap['status'] as String? ?? '';
                 if (status == 'created' || status == 'delivering' || status == 'calling' || status == 'ringing') {
                   return CallModel.fromJson(callMap);
                 }
               }
            }
          }
        }
      } catch (_) {}
      return null;
    });
  }

  @override
  Future<void> storeCallHistory(CallModel call) async {
    await _firestore.collection('callHistory').doc(call.callId).set(call.toJson());
  }

  @override
  Future<void> setReadyStatus(String callId, String userId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.ref('calls/$callId/ready/$userId').set(now);
  }

  @override
  Stream<Map<String, dynamic>> watchReadyStatus(String callId) {
    return _database.ref('calls/$callId/ready').onValue.map((event) {
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
  Future<void> clearReadyStatuses(String callId) async {
    await _database.ref('calls/$callId/ready').remove();
  }
}
