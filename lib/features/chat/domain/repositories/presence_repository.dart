import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';

abstract class PresenceRepository {
  /// Stream of presence updates for a given userId
  Stream<PresenceStatus> watchPresence(String userId);

  /// Manually update online status of a user
  Future<void> setUserOnline(String userId, bool online);

  /// Manually update presence status of a user
  Future<void> setUserStatus(String userId, PresenceStatusType status);

  /// Set up automatic offline state on network/socket disconnect
  Future<void> setupOnDisconnect(String userId);

  /// Force the underlying database connection online
  Future<void> goOnline();

  /// Force the underlying database connection offline
  Future<void> goOffline();

  /// Watch connection state of the client to the database
  Stream<bool> watchConnectionState();
}
