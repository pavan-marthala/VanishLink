import 'package:flutter/foundation.dart';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';

abstract class NotificationDispatcher {
  /// Dispatches the strongly-typed [NotificationPayload] to the receiver.
  /// Future calling and message systems will utilize this abstraction to trigger push delivery.
  Future<void> dispatch(NotificationPayload payload);
}

class NotificationDispatcherImpl implements NotificationDispatcher {
  @override
  Future<void> dispatch(NotificationPayload payload) async {
    // Establishing the contract and architectural layout for push triggers.
    // In a production serverless environment, this writes to a queue collection
    // or queries recipient tokens to trigger FCM POST requests.
    debugPrint('[NotificationDispatcher] Contract dispatched successfully:');
    debugPrint('Payload ID: ${payload.id}');
    debugPrint('Payload Type: ${payload.type.name}');
    debugPrint('Payload Title: ${payload.title}');
    debugPrint('Payload Body: ${payload.body}');
    debugPrint('Raw Details: ${payload.toJson()}');
  }
}
