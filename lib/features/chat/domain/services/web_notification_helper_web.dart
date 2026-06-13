// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';

void setupWebNotificationListener(StreamController<NotificationPayload> tapStreamController) {
  html.window.addEventListener('message', (html.Event event) {
    if (event is html.MessageEvent) {
      final data = event.data;
      if (data is Map && data['type'] == 'NOTIFICATION_TAP') {
        debugPrint('[WebNotificationHelper] Received NOTIFICATION_TAP message event from SW: $data');
        try {
          final payloadMap = Map<String, dynamic>.from(data['payload'] as Map);
          final payload = NotificationPayload.fromJson(payloadMap);
          tapStreamController.add(payload);
        } catch (e) {
          debugPrint('[WebNotificationHelper] Error parsing message event payload: $e');
        }
      }
    }
  });
}
