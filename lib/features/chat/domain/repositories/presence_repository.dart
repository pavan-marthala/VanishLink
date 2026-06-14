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

  /// Updates the device's push token registration details and permission flags in RTDB
  Future<void> updateDevicePushToken({
    required String userId,
    required String deviceId,
    required String token,
    required String platform,
    required bool notificationPermission,
    required bool microphonePermission,
    required bool cameraPermission,
  });

  /// Deletes the device's push token registration from the user record
  Future<void> removeDevicePushToken(String userId, String deviceId);

  /// Set the user's busy status flag
  Future<void> setUserBusy(String userId, bool busy);

  /// Aggregates, filters, and deduplicates active push tokens for a given user
  Future<List<String>> getUserDeviceTokens(String userId);
}
