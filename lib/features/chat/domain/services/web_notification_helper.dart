import 'dart:async';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';

void setupWebNotificationListener(StreamController<NotificationPayload> tapStreamController) {
  // No-op on native platforms
}
