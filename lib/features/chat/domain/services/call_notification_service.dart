import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CallNotificationService {
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

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
    );
    _isInitialized = true;
  }

  Future<void> showIncomingCallNotification({
    required String callId,
    required String callerName,
    required String type,
  }) async {
    if (kIsWeb) return;
    await initialize();
    const androidDetails = AndroidNotificationDetails(
      'call_channel',
      'Calls',
      channelDescription: 'Incoming and active calls notifications',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.call,
    );
    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'incoming_call_category',
    );
    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);
    
    await _localNotifications.show(
      id: callId.hashCode,
      title: 'Incoming $type call',
      body: '$callerName is calling you...',
      notificationDetails: details,
      payload: callId,
    );
  }

  Future<void> showMissedCallNotification({
    required String callId,
    required String callerName,
    required String type,
  }) async {
    if (kIsWeb) return;
    await initialize();
    const androidDetails = AndroidNotificationDetails(
      'missed_call_channel',
      'Missed Calls',
      channelDescription: 'Missed calls notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);
    
    await _localNotifications.show(
      id: callId.hashCode ^ 999,
      title: 'Missed Call',
      body: 'You missed a $type call from $callerName',
      notificationDetails: details,
    );
  }

  Future<void> showCallEndedNotification({
    required String callId,
    required String callerName,
    required String type,
  }) async {
    if (kIsWeb) return;
    await initialize();
    await _localNotifications.cancel(id: callId.hashCode);
  }

  Future<void> cancelAll() async {
    if (kIsWeb) return;
    await _localNotifications.cancelAll();
  }
}
