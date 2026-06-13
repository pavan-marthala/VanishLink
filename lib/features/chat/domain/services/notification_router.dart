import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';
import 'package:vanish_link/features/chat/domain/services/notification_service.dart';
import 'package:vanish_link/features/chat/domain/services/notification_presenter.dart';
import 'package:vanish_link/features/chat/domain/services/call_coordinator.dart';
import 'package:vanish_link/main.dart';

class NotificationRouter {
  final NotificationService _notificationService;
  final NotificationPresenter _notificationPresenter;
  final CallCoordinator _callCoordinator;
  StreamSubscription<NotificationPayload>? _notificationSubscription;
  StreamSubscription<NotificationPayload>? _tapSubscription;

  NotificationRouter({
    required NotificationService notificationService,
    required NotificationPresenter notificationPresenter,
    required CallCoordinator callCoordinator,
  })  : _notificationService = notificationService,
        _notificationPresenter = notificationPresenter,
        _callCoordinator = callCoordinator;

  void start() {
    _notificationSubscription?.cancel();
    _notificationSubscription = _notificationService.onNotification.listen(route);

    _tapSubscription?.cancel();
    _tapSubscription = _notificationService.onTapNotification.listen((payload) {
      debugPrint('[NotificationRouter] Notification tapped by user: ${payload.id}');
      handleTapNavigation(payload);
    });
    
    debugPrint('NotificationRouter started listening to streams.');
  }

  void stop() {
    _notificationSubscription?.cancel();
    _tapSubscription?.cancel();
    debugPrint('NotificationRouter stopped listening.');
  }

  void route(NotificationPayload payload) {
    debugPrint('[NotificationRouter] Processing route for type: ${payload.type.name}');

    switch (payload.type) {
      case NotificationType.incomingCall:
        final callId = payload.callId;
        if (callId != null) {
          debugPrint('[NotificationRouter] Routing incomingCall payload to CallCoordinator ($callId). Target coordinator: $_callCoordinator');
          // In subsequent phases, this will invoke the CallKit UI or sync active call state
        }
        break;
      case NotificationType.missedCall:
        _notificationPresenter.showMissedCallNotification(
          id: payload.id,
          title: payload.title,
          body: payload.body,
          payloadData: payload.data ?? {},
        );
        break;
      case NotificationType.newMessage:
      case NotificationType.messageReaction:
      case NotificationType.mention:
        _notificationPresenter.showChatNotification(
          id: payload.id,
          title: payload.title,
          body: payload.body,
          payloadData: payload.data ?? {},
        );
        break;
      case NotificationType.system:
        _notificationPresenter.showSystemNotification(
          id: payload.id,
          title: payload.title,
          body: payload.body,
          payloadData: payload.data ?? {},
        );
        break;
      default:
        debugPrint('[NotificationRouter] Unhandled notification type');
        break;
    }
  }

  void handleTapNavigation(NotificationPayload payload) {
    debugPrint('[NotificationRouter] Handling tap navigation for payload type: ${payload.type.name}');
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      debugPrint('[NotificationRouter] Navigation skipped: Root Context is null.');
      return;
    }

    switch (payload.type) {
      case NotificationType.newMessage:
      case NotificationType.mention:
      case NotificationType.messageReaction:
        final chatId = payload.chatId ?? payload.data?['chatId'] as String?;
        if (chatId != null && chatId.isNotEmpty) {
          context.go('/chats/$chatId');
        } else {
          context.go('/chats');
        }
        break;
      case NotificationType.incomingCall:
        final callId = payload.callId ?? payload.data?['callId'] as String?;
        if (callId != null && callId.isNotEmpty) {
          context.go('/call/$callId');
        }
        break;
      case NotificationType.missedCall:
        context.go('/chats');
        break;
      case NotificationType.system:
      default:
        context.go('/chats');
        break;
    }
  }
}
