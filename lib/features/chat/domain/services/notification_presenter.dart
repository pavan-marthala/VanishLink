import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class NotificationPresenter {
  Future<void> initialize();
  Future<void> showChatNotification({
    required String id,
    required String title,
    required String body,
    required Map<String, dynamic> payloadData,
  });
  Future<void> showSystemNotification({
    required String id,
    required String title,
    required String body,
    required Map<String, dynamic> payloadData,
  });
  Future<void> showMissedCallNotification({
    required String id,
    required String title,
    required String body,
    required Map<String, dynamic> payloadData,
  });
}

class NotificationPresenterImpl implements NotificationPresenter {
  final FlutterLocalNotificationsPlugin _localNotifications;
  bool _isInitialized = false;

  NotificationPresenterImpl({
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _localNotifications = localNotifications ?? FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    if (kIsWeb) return;
    if (_isInitialized) return;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android channels
    await _createNotificationChannels();

    _isInitialized = true;
    debugPrint('NotificationPresenter initialized successfully.');
  }

  Future<void> _createNotificationChannels() async {
    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      // 1. Chat notifications channel
      const chatChannel = AndroidNotificationChannel(
        'chat_notifications_v2',
        'Chat Messages',
        description: 'Direct messages and mentions',
        importance: Importance.max,
        playSound: true,
      );

      // 2. System notifications channel
      const systemChannel = AndroidNotificationChannel(
        'system_notifications_v2',
        'System Alerts',
        description: 'Administrative and service alerts',
        importance: Importance.max,
        playSound: true,
      );

      // 3. Missed calls channel
      const missedCallChannel = AndroidNotificationChannel(
        'missed_call_notifications_v2',
        'Missed Calls',
        description: 'Missed call notifications',
        importance: Importance.max,
        playSound: true,
      );

      await androidPlugin.createNotificationChannel(chatChannel);
      await androidPlugin.createNotificationChannel(systemChannel);
      await androidPlugin.createNotificationChannel(missedCallChannel);
      debugPrint('[NotificationPresenter] Android Notification Channels (v2) created.');
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('[NotificationPresenter] Local notification tapped: ${response.payload}');
  }

  Future<bool> _checkPermission() async {
    final granted = await Permission.notification.isGranted;
    debugPrint('[NotificationPresenter] Checked permission status: $granted');
    if (!granted) {
      debugPrint('[NotificationPresenter] Skip display: notification permission denied.');
    }
    return granted;
  }

  @override
  Future<void> showChatNotification({
    required String id,
    required String title,
    required String body,
    required Map<String, dynamic> payloadData,
  }) async {
    if (kIsWeb) return;
    if (!await _checkPermission()) return;

    debugPrint('[NotificationPresenter] Showing chat notification: $id');
    final androidDetails = AndroidNotificationDetails(
      'chat_notifications_v2',
      'Chat Messages',
      channelDescription: 'Direct messages and mentions',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    final iosDetails = const DarwinNotificationDetails();
    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _localNotifications.show(
      id: id.hashCode,
      title: title,
      body: body,
      notificationDetails: details,
      payload: id,
    );
  }

  @override
  Future<void> showSystemNotification({
    required String id,
    required String title,
    required String body,
    required Map<String, dynamic> payloadData,
  }) async {
    if (kIsWeb) return;
    if (!await _checkPermission()) return;

    debugPrint('[NotificationPresenter] Showing system notification: $id');
    final androidDetails = AndroidNotificationDetails(
      'system_notifications_v2',
      'System Alerts',
      channelDescription: 'Administrative and service alerts',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    final iosDetails = const DarwinNotificationDetails();
    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _localNotifications.show(
      id: id.hashCode,
      title: title,
      body: body,
      notificationDetails: details,
      payload: id,
    );
  }

  @override
  Future<void> showMissedCallNotification({
    required String id,
    required String title,
    required String body,
    required Map<String, dynamic> payloadData,
  }) async {
    if (kIsWeb) return;
    if (!await _checkPermission()) return;

    debugPrint('[NotificationPresenter] Showing missed call notification: $id');
    final androidDetails = AndroidNotificationDetails(
      'missed_call_notifications_v2',
      'Missed Calls',
      channelDescription: 'Missed call notifications',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    final iosDetails = const DarwinNotificationDetails();
    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _localNotifications.show(
      id: id.hashCode,
      title: title,
      body: body,
      notificationDetails: details,
      payload: id,
    );
  }
}
