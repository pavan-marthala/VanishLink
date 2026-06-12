import 'dart:async';
import 'package:flutter_callkit_incoming/entities/call_event.dart' as ck;
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

abstract class CallPresentationAdapter {
  Stream<ck.CallEvent?>? get onEvent;
  Future<void> showIncomingCall({
    required String callId,
    required String callerName,
    required String type,
  });
  Future<void> endCall(String callId);
  Future<void> endAllCalls();
}

class AndroidCallAdapter implements CallPresentationAdapter {
  @override
  Stream<ck.CallEvent?>? get onEvent => FlutterCallkitIncoming.onEvent;

  @override
  Future<void> showIncomingCall({
    required String callId,
    required String callerName,
    required String type,
  }) async {
    final params = CallKitParams(
      id: callId,
      nameCaller: callerName,
      appName: 'VanishLink',
      avatar: 'https://via.placeholder.com/150',
      handle: 'VanishLink Call',
      type: type == 'video' ? 1 : 0,
      duration: 30000,
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: false,
        subtitle: 'Missed Call',
        callbackText: 'Call Back',
      ),
      android: AndroidParams(
        isCustomNotification: false,
        isShowLogo: false,
        ringtonePath: 'ringtone',
        backgroundColor: '#090A0F',
        actionColor: '#4CAF50',
        textAccept: 'Accept',
        textDecline: 'Decline',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  @override
  Future<void> endCall(String callId) async {
    await FlutterCallkitIncoming.endCall(callId);
  }

  @override
  Future<void> endAllCalls() async {
    await FlutterCallkitIncoming.endAllCalls();
  }
}

class IOSCallAdapter implements CallPresentationAdapter {
  @override
  Stream<ck.CallEvent?>? get onEvent => FlutterCallkitIncoming.onEvent;

  @override
  Future<void> showIncomingCall({
    required String callId,
    required String callerName,
    required String type,
  }) async {
    final params = CallKitParams(
      id: callId,
      nameCaller: callerName,
      appName: 'VanishLink',
      avatar: 'https://via.placeholder.com/150',
      handle: 'VanishLink Call',
      type: type == 'video' ? 1 : 0,
      duration: 30000,
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: false,
        subtitle: 'Missed Call',
        callbackText: 'Call Back',
      ),
      ios: const IOSParams(
        iconName: 'AppIcon',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'ringtone.mp3',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  @override
  Future<void> endCall(String callId) async {
    await FlutterCallkitIncoming.endCall(callId);
  }

  @override
  Future<void> endAllCalls() async {
    await FlutterCallkitIncoming.endAllCalls();
  }
}

class WebCallAdapter implements CallPresentationAdapter {
  @override
  Stream<ck.CallEvent?>? get onEvent => const Stream.empty();

  @override
  Future<void> showIncomingCall({
    required String callId,
    required String callerName,
    required String type,
  }) async {
    // Custom overlay handles everything reactively
  }

  @override
  Future<void> endCall(String callId) async {}

  @override
  Future<void> endAllCalls() async {}
}

class DesktopCallAdapter implements CallPresentationAdapter {
  @override
  Stream<ck.CallEvent?>? get onEvent => const Stream.empty();

  @override
  Future<void> showIncomingCall({
    required String callId,
    required String callerName,
    required String type,
  }) async {
    // Custom overlay handles everything reactively
  }

  @override
  Future<void> endCall(String callId) async {}

  @override
  Future<void> endAllCalls() async {}
}
