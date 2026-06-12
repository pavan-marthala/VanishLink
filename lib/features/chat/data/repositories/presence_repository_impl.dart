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

        final online = data['online'] as bool? ?? false;
        final lastSeenRaw = data['lastSeen'];
        int lastSeenMs = 0;
        if (lastSeenRaw is int) {
          lastSeenMs = lastSeenRaw;
        } else if (lastSeenRaw is double) {
          lastSeenMs = lastSeenRaw.toInt();
        }

        return PresenceStatus(
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
    if (userId.isEmpty) return;

    await _database.ref('presence/$userId').update({
      'online': online,
      'lastSeen': ServerValue.timestamp,
    });
  }

  @override
  Future<void> setupOnDisconnect(String userId) async {
    if (userId.isEmpty) return;

    final ref = _database.ref('presence/$userId');
    await ref.onDisconnect().update({
      'online': false,
      'lastSeen': ServerValue.timestamp,
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
}
