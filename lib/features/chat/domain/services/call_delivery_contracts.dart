import 'package:flutter/foundation.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';

abstract class CallDeliveryNotificationTrigger {
  /// Triggers FCM push notification payload delivery to all recipient devices for incoming calls.
  Future<void> triggerIncomingCallPush(CallModel call);

  /// Triggers push notification payload delivery for missed call records.
  Future<void> triggerMissedCallPush(CallModel call);

  /// Triggers push notification payload delivery for call timeouts.
  Future<void> triggerTimeoutCallPush(CallModel call);
}

class CallDeliveryNotificationTriggerImpl implements CallDeliveryNotificationTrigger {
  @override
  Future<void> triggerIncomingCallPush(CallModel call) async {
    // Contract implementation hook: Log diagnostic details only.
    // Production system will look up active devices and dispatch push payloads.
    debugPrint('[CallDeliveryTrigger] Triggered incoming call push payload for: ${call.callId}');
  }

  @override
  Future<void> triggerMissedCallPush(CallModel call) async {
    debugPrint('[CallDeliveryTrigger] Triggered missed call push payload for: ${call.callId}');
  }

  @override
  Future<void> triggerTimeoutCallPush(CallModel call) async {
    debugPrint('[CallDeliveryTrigger] Triggered timeout call push payload for: ${call.callId}');
  }
}
