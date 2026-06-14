import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';
import 'package:vanish_link/features/chat/domain/services/web_notification_helper.dart'
    if (dart.library.html) 'package:vanish_link/features/chat/domain/services/web_notification_helper_web.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized if we need to call database, but since this runs in a separate isolate
  // we just log it or handle minimal work here.
  debugPrint('Handling a background message: ${message.messageId}');
}

class NotificationService {
  final FirebaseMessaging _fcm;
  final StreamController<NotificationPayload> _notificationStreamController =
      StreamController<NotificationPayload>.broadcast();
  final StreamController<NotificationPayload> _tapStreamController =
      StreamController<NotificationPayload>.broadcast();

  NotificationService({FirebaseMessaging? fcm})
      : _fcm = fcm ?? FirebaseMessaging.instance;

  Stream<NotificationPayload> get onNotification => _notificationStreamController.stream;
  Stream<NotificationPayload> get onTapNotification => _tapStreamController.stream;

  bool _isInitialized = false;

  /// Exposes current notification permission status.
  Future<bool> get hasNotificationPermission async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  Future<void> initialize() async {
    if (_isInitialized) return;

    debugPrint('[NotificationService] Initializing Notification Stack (Web support enabled)...');

    // Register background handler on native platforms only
    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      debugPrint('[NotificationService] Registered Native background push handler.');
    } else {
      // Setup listener for service worker tapped notifications
      setupWebNotificationListener(_tapStreamController);
      debugPrint('[NotificationService] Registered Web SW message event listener.');
    }

    // Request permissions dynamically
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Fetch token for diagnostics
    try {
      final token = await _fcm.getToken();
      debugPrint('[NotificationService] FCM Token retrieved successfully: $token');
    } catch (e) {
      debugPrint('[NotificationService] Diagnostics error fetching token: $e');
    }

    // Foreground listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('[NotificationService] Foreground message received: ${message.messageId}');
      final payload = _parseRemoteMessage(message);
      _notificationStreamController.add(payload);
    });

    // Background tap listener (App was in background but still running)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('[NotificationService] Message opened app from background: ${message.messageId}');
      final payload = _parseRemoteMessage(message);
      _tapStreamController.add(payload);
    });

    // Terminated launch scenario (App was completely closed)
    if (!kIsWeb) {
      final initialMessage = await _fcm.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('[NotificationService] App launched from terminated state via initial message: ${initialMessage.messageId}');
        final payload = _parseRemoteMessage(initialMessage);
        // Wait a short delay so listeners have registered
        Future.delayed(const Duration(milliseconds: 500), () {
          _tapStreamController.add(payload);
        });
      }
    }

    _isInitialized = true;
    debugPrint('NotificationService initialized successfully.');
  }

  NotificationPayload _parseRemoteMessage(RemoteMessage message) {
    final data = message.data;
    final id = message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString();
    final title = message.notification?.title ?? data['title'] as String? ?? 'VanishLink';
    final body = message.notification?.body ?? data['body'] as String? ?? '';

    // Extract structure from raw FCM data payload
    return NotificationPayload(
      id: id,
      type: _parseType(data['type'] as String?),
      title: title,
      body: body,
      senderId: data['senderId'] as String?,
      receiverId: data['receiverId'] as String?,
      callId: data['callId'] as String?,
      chatId: data['chatId'] as String?,
      createdAt: DateTime.now(),
      data: data,
    );
  }

  NotificationType _parseType(String? typeString) {
    if (typeString == null) return NotificationType.system;
    switch (typeString) {
      case 'incomingCall':
        return NotificationType.incomingCall;
      case 'missedCall':
        return NotificationType.missedCall;
      case 'callDeclined':
        return NotificationType.callDeclined;
      case 'callEnded':
        return NotificationType.callEnded;
      case 'newMessage':
        return NotificationType.newMessage;
      case 'messageReaction':
        return NotificationType.messageReaction;
      case 'mention':
        return NotificationType.mention;
      case 'system':
      default:
        return NotificationType.system;
    }
  }

  void dispose() {
    _notificationStreamController.close();
    _tapStreamController.close();
  }
}
