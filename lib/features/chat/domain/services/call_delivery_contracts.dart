import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';
import 'package:vanish_link/features/chat/domain/services/notification_dispatcher.dart';

abstract class CallDeliveryNotificationTrigger {
  /// Triggers FCM push notification payload delivery to all recipient devices for incoming calls.
  Future<void> triggerIncomingCallPush(CallModel call);

  /// Triggers push notification payload delivery for missed call records.
  Future<void> triggerMissedCallPush(CallModel call);

  /// Triggers push notification payload delivery for call timeouts.
  Future<void> triggerTimeoutCallPush(CallModel call);

  /// Triggers push notification payload delivery for declined call events.
  Future<void> triggerDeclinedCallPush(CallModel call);

  /// Triggers push notification payload delivery for ended call events.
  Future<void> triggerEndedCallPush(CallModel call);
}

class CallDeliveryNotificationTriggerImpl implements CallDeliveryNotificationTrigger {
  final NotificationDispatcher _dispatcher;

  CallDeliveryNotificationTriggerImpl({
    NotificationDispatcher? dispatcher,
  }) : _dispatcher = dispatcher ?? getIt<NotificationDispatcher>();

  @override
  Future<void> triggerIncomingCallPush(CallModel call) async {
    debugPrint('[CallDeliveryTrigger] Triggered incoming call push payload for: ${call.callId}');
    final payload = NotificationPayload(
      id: call.callId,
      type: NotificationType.incomingCall,
      title: call.type == CallType.video ? 'Incoming Video Call' : 'Incoming Voice Call',
      body: 'Incoming call from ${call.callerId}',
      senderId: call.callerId,
      receiverId: call.receiverId,
      callId: call.callId,
      createdAt: DateTime.now(),
      data: {
        'callId': call.callId,
        'callerId': call.callerId,
        'receiverId': call.receiverId,
        'type': call.type.name,
        'status': call.status,
      },
    );
    await _dispatcher.dispatch(payload);
  }

  @override
  Future<void> triggerMissedCallPush(CallModel call) async {
    debugPrint('[CallDeliveryTrigger] Triggered missed call push payload for: ${call.callId}');
    final payload = NotificationPayload(
      id: '${call.callId}_missed',
      type: NotificationType.missedCall,
      title: 'Missed Call',
      body: 'Missed call from ${call.callerId}',
      senderId: call.callerId,
      receiverId: call.receiverId,
      callId: call.callId,
      createdAt: DateTime.now(),
      data: {
        'callId': call.callId,
        'callerId': call.callerId,
        'receiverId': call.receiverId,
        'type': call.type.name,
        'status': 'missed',
      },
    );
    await _dispatcher.dispatch(payload);
  }

  @override
  Future<void> triggerTimeoutCallPush(CallModel call) async {
    debugPrint('[CallDeliveryTrigger] Triggered timeout call push payload for: ${call.callId}');
    final payload = NotificationPayload(
      id: '${call.callId}_timeout',
      type: NotificationType.system,
      title: 'Call Timeout',
      body: 'Call with ${call.callerId} timed out',
      senderId: call.callerId,
      receiverId: call.receiverId,
      callId: call.callId,
      createdAt: DateTime.now(),
      data: {
        'callId': call.callId,
        'callerId': call.callerId,
        'receiverId': call.receiverId,
        'type': call.type.name,
        'status': 'timeout',
      },
    );
    await _dispatcher.dispatch(payload);
  }

  @override
  Future<void> triggerDeclinedCallPush(CallModel call) async {
    debugPrint('[CallDeliveryTrigger] Triggered declined call push payload for: ${call.callId}');
    final payload = NotificationPayload(
      id: '${call.callId}_declined',
      type: NotificationType.callDeclined,
      title: 'Call Declined',
      body: 'Call declined by ${call.receiverId}',
      senderId: call.receiverId, // Receiver is the one who declined
      receiverId: call.callerId, // Target of the decline is the caller
      callId: call.callId,
      createdAt: DateTime.now(),
      data: {
        'callId': call.callId,
        'callerId': call.callerId,
        'receiverId': call.receiverId,
        'type': call.type.name,
        'status': 'declined',
      },
    );
    await _dispatcher.dispatch(payload);
  }

  @override
  Future<void> triggerEndedCallPush(CallModel call) async {
    debugPrint('[CallDeliveryTrigger] Triggered ended call push payload for: ${call.callId}');
    
    // Target the peer device (non-initiator)
    final currentUserId = getIt.isRegistered<FirebaseAuth>() ? getIt<FirebaseAuth>().currentUser?.uid : FirebaseAuth.instance.currentUser?.uid;
    final peerId = call.callerId == currentUserId ? call.receiverId : call.callerId;

    final payload = NotificationPayload(
      id: '${call.callId}_ended',
      type: NotificationType.callEnded,
      title: 'Call Ended',
      body: 'Call has ended',
      senderId: currentUserId ?? call.callerId,
      receiverId: peerId,
      callId: call.callId,
      createdAt: DateTime.now(),
      data: {
        'callId': call.callId,
        'callerId': call.callerId,
        'receiverId': call.receiverId,
        'type': call.type.name,
        'status': 'ended',
      },
    );
    await _dispatcher.dispatch(payload);
  }
}
