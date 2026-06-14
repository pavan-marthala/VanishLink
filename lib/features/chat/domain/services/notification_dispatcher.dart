import 'package:flutter/foundation.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/services/backend_notification_client.dart';

abstract class NotificationDispatcher {
  /// Dispatches the strongly-typed [NotificationPayload] to the receiver.
  /// Future calling and message systems will utilize this abstraction to trigger push delivery.
  Future<void> dispatch(NotificationPayload payload);
}

class NotificationDispatcherImpl implements NotificationDispatcher {
  final PresenceRepository _presenceRepository;
  final BackendNotificationClient _backendClient;

  NotificationDispatcherImpl({
    PresenceRepository? presenceRepository,
    BackendNotificationClient? backendClient,
  })  : _presenceRepository = presenceRepository ?? getIt<PresenceRepository>(),
        _backendClient = backendClient ?? getIt<BackendNotificationClient>();

  @override
  Future<void> dispatch(NotificationPayload payload) async {
    final receiverId = payload.receiverId;
    if (receiverId == null || receiverId.isEmpty) {
      debugPrint('[NotificationDispatcher] Cancelled: receiverId is empty in payload.');
      return;
    }

    debugPrint('[PUSH-DELIVERY] Starting push delivery for receiverId=$receiverId, type=${payload.type.name}');

    try {
      final tokens = await _presenceRepository.getUserDeviceTokens(receiverId);
      if (tokens.isEmpty) {
        debugPrint('[NotificationDispatcher] No active device tokens found for receiverId=$receiverId');
        return;
      }

      await _backendClient.sendNotification(
        tokens: tokens,
        title: payload.title,
        body: payload.body,
        payload: payload,
      );
    } catch (e) {
      debugPrint('[NotificationDispatcher] Error dispatching push notification: $e');
    }
  }
}
