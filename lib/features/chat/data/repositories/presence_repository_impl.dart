import 'package:firebase_database/firebase_database.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';

class PresenceRepositoryImpl implements PresenceRepository {
  final FirebaseDatabase _database;

  PresenceRepositoryImpl({FirebaseDatabase? database})
      : _database = database ?? FirebaseDatabase.instance;

  @override
  Stream<PresenceStatus> watchPresence(String userId) {
    if (userId.isEmpty) {
      return Stream.value(PresenceStatus.offline());
    }

    return _database.ref('presence/$userId').onValue.map((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists || snapshot.value == null) {
        return PresenceStatus.offline();
      }

      try {
        final Map<dynamic, dynamic> data;
        if (snapshot.value is Map) {
          data = snapshot.value as Map;
        } else {
          return PresenceStatus.offline();
        }

        final statusStr = data['status'] as String? ?? '';
        final PresenceStatusType status;
        final bool online;

        if (statusStr == 'online') {
          status = PresenceStatusType.online;
          online = true;
        } else if (statusStr == 'background') {
          status = PresenceStatusType.background;
          online = true;
        } else if (statusStr == 'offline') {
          status = PresenceStatusType.offline;
          online = false;
        } else {
          final legacyOnline = data['online'] as bool? ?? false;
          status = legacyOnline ? PresenceStatusType.online : PresenceStatusType.offline;
          online = legacyOnline;
        }

        final lastSeenRaw = data['lastSeen'];
        int lastSeenMs = 0;
        if (lastSeenRaw is int) {
          lastSeenMs = lastSeenRaw;
        } else if (lastSeenRaw is double) {
          lastSeenMs = lastSeenRaw.toInt();
        }

        return PresenceStatus(
          status: status,
          online: online,
          lastSeen: DateTime.fromMillisecondsSinceEpoch(lastSeenMs),
        );
      } catch (_) {
        return PresenceStatus.offline();
      }
    });
  }

  @override
  Future<void> setUserOnline(String userId, bool online) async {
    await setUserStatus(
      userId,
      online ? PresenceStatusType.online : PresenceStatusType.offline,
    );
  }

  @override
  Future<void> setUserStatus(String userId, PresenceStatusType status) async {
    if (userId.isEmpty) return;

    await _database.ref('presence/$userId').update({
      'status': status.name,
      'online': status != PresenceStatusType.offline,
      'lastSeen': ServerValue.timestamp,
    });
  }

  @override
  Future<void> setupOnDisconnect(String userId) async {
    if (userId.isEmpty) return;

    final ref = _database.ref('presence/$userId');
    await ref.onDisconnect().update({
      'status': PresenceStatusType.offline.name,
      'online': false,
      'lastSeen': ServerValue.timestamp,
      'busy': false,
    });
  }

  @override
  Future<void> setUserBusy(String userId, bool busy) async {
    if (userId.isEmpty) return;
    await _database.ref('presence/$userId').update({
      'busy': busy,
    });
  }

  @override
  Future<void> goOnline() async {
    await _database.goOnline();
  }

  @override
  Future<void> goOffline() async {
    await _database.goOffline();
  }

  @override
  Stream<bool> watchConnectionState() {
    return _database.ref('.info/connected').onValue.map((event) {
      return event.snapshot.value as bool? ?? false;
    });
  }

  @override
  Future<void> updateDevicePushToken({
    required String userId,
    required String deviceId,
    required String token,
    required String platform,
    required bool notificationPermission,
    required bool microphonePermission,
    required bool cameraPermission,
  }) async {
    if (userId.isEmpty || deviceId.isEmpty) return;

    await _database.ref('presence/$userId/devices/$deviceId').update({
      'platform': platform,
      'pushProvider': 'fcm',
      'pushToken': token,
      'lastActiveAt': ServerValue.timestamp,
      'notificationPermission': notificationPermission,
      'microphonePermission': microphonePermission,
      'cameraPermission': cameraPermission,
    });
  }

  @override
  Future<void> removeDevicePushToken(String userId, String deviceId) async {
    if (userId.isEmpty || deviceId.isEmpty) return;

    await _database.ref('presence/$userId/devices/$deviceId').remove();
  }
}
