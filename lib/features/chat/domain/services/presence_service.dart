import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vanish_link/core/utils/device_identifier_provider.dart';
import 'package:vanish_link/core/services/permission_manager.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';

class PresenceService with WidgetsBindingObserver {
  final PresenceRepository _presenceRepository;
  final DeviceIdentifierProvider _deviceIdentifierProvider;
  final FirebaseAuth _auth;
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<bool>? _connectionSubscription;
  StreamSubscription<String>? _tokenRefreshSubscription;
  String? _currentUserId;

  PresenceService({
    required PresenceRepository presenceRepository,
    required DeviceIdentifierProvider deviceIdentifierProvider,
    FirebaseAuth? auth,
  })  : _presenceRepository = presenceRepository,
        _deviceIdentifierProvider = deviceIdentifierProvider,
        _auth = auth ?? FirebaseAuth.instance;

  /// Starts listening to authentication and app lifecycle changes
  void startMonitoring() {
    WidgetsBinding.instance.addObserver(this);
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        _currentUserId = user.uid;
        _presenceRepository.goOnline();
        _updateStatus(PresenceStatusType.online);
        _registerDevicePushToken();

        _connectionSubscription?.cancel();
        _connectionSubscription = _presenceRepository
            .watchConnectionState()
            .listen((connected) {
          if (connected && _currentUserId != null) {
            _updateStatus(PresenceStatusType.online);
            _registerDevicePushToken();
          }
        });
      } else {
        if (_currentUserId != null) {
          _connectionSubscription?.cancel();
          _connectionSubscription = null;
          _tokenRefreshSubscription?.cancel();
          _tokenRefreshSubscription = null;
          _updateStatus(PresenceStatusType.offline);
          _currentUserId = null;
        }
      }
    });
  }

  /// Stops monitoring and cleans up listeners
  void stopMonitoring() {
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription?.cancel();
    _connectionSubscription?.cancel();
    _connectionSubscription = null;
    _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = null;
    if (_currentUserId != null) {
      _updateStatus(PresenceStatusType.offline);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_currentUserId == null) return;

    if (state == AppLifecycleState.resumed) {
      _presenceRepository.goOnline();
      _updateStatus(PresenceStatusType.online);
      _registerDevicePushToken();
    } else if (state == AppLifecycleState.paused) {
      _updateStatus(PresenceStatusType.background);
    } else if (state == AppLifecycleState.detached) {
      _updateStatus(PresenceStatusType.offline);
    }
  }

  Future<void> _registerDevicePushToken() async {
    final uid = _currentUserId;
    if (uid == null) return;

    try {
      final deviceId = await _deviceIdentifierProvider.getIdentifier();
      final platform = await _deviceIdentifierProvider.getPlatform();

      // Check system permissions
      final pm = getIt<PermissionManager>();
      final notificationGranted = (await pm.checkPermissionStatus(VanishPermissionType.notification)) == VanishPermissionStatus.granted;
      final microphoneGranted = (await pm.checkPermissionStatus(VanishPermissionType.microphone)) == VanishPermissionStatus.granted;
      final cameraGranted = (await pm.checkPermissionStatus(VanishPermissionType.camera)) == VanishPermissionStatus.granted;

      // Retrieve Firebase messaging push token
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      final token = await messaging.getToken();
      if (token != null) {
        await _presenceRepository.updateDevicePushToken(
          userId: uid,
          deviceId: deviceId,
          token: token,
          platform: platform,
          notificationPermission: notificationGranted,
          microphonePermission: microphoneGranted,
          cameraPermission: cameraGranted,
        );
        debugPrint('[DIAG-PUSH] push token registered successfully for device: $deviceId');
      }

      // Track token refresh events
      _tokenRefreshSubscription?.cancel();
      _tokenRefreshSubscription = messaging.onTokenRefresh.listen((newToken) async {
        if (_currentUserId == uid) {
          final pm = getIt<PermissionManager>();
          final notif = (await pm.checkPermissionStatus(VanishPermissionType.notification)) == VanishPermissionStatus.granted;
          final mic = (await pm.checkPermissionStatus(VanishPermissionType.microphone)) == VanishPermissionStatus.granted;
          final cam = (await pm.checkPermissionStatus(VanishPermissionType.camera)) == VanishPermissionStatus.granted;
          await _presenceRepository.updateDevicePushToken(
            userId: uid,
            deviceId: deviceId,
            token: newToken,
            platform: platform,
            notificationPermission: notif,
            microphonePermission: mic,
            cameraPermission: cam,
          );
        }
      });
    } catch (e) {
      debugPrint('Error registering device push token: $e');
    }
  }

  void _updateStatus(PresenceStatusType status) async {
    final uid = _currentUserId;
    if (uid == null) return;
    if (status == PresenceStatusType.online) {
      await _presenceRepository.setupOnDisconnect(uid);
      await _presenceRepository.setUserStatus(uid, PresenceStatusType.online);
    } else if (status == PresenceStatusType.background) {
      await _presenceRepository.setUserStatus(uid, PresenceStatusType.background);
    } else {
      await _presenceRepository.setUserStatus(uid, PresenceStatusType.offline);
      await _presenceRepository.goOffline();
    }
  }
}
