import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum VanishPermissionType { notification, microphone, camera }

enum VanishPermissionStatus { granted, denied, permanentlyDenied, restricted }

abstract class PermissionManager {
  Future<VanishPermissionStatus> checkPermissionStatus(VanishPermissionType type);
  Future<VanishPermissionStatus> requestPermission(VanishPermissionType type);
  Future<bool> openSettings();
  Stream<Map<VanishPermissionType, VanishPermissionStatus>> get permissionStream;
  Future<void> recheckAll();
  Future<bool> isOnboardingCompleted();
  bool isOnboardingCompletedSync();
  Future<void> completeOnboarding();
}

class PermissionManagerImpl implements PermissionManager {
  final SharedPreferences _prefs;
  static const _onboardingKey = 'vanish_link_onboarding_completed';

  final _permissionStreamController = StreamController<Map<VanishPermissionType, VanishPermissionStatus>>.broadcast();
  final Map<VanishPermissionType, VanishPermissionStatus> _cache = {};

  PermissionManagerImpl(this._prefs) {
    // Initial status check
    recheckAll();
  }

  @override
  Stream<Map<VanishPermissionType, VanishPermissionStatus>> get permissionStream => _permissionStreamController.stream;

  @override
  Future<VanishPermissionStatus> checkPermissionStatus(VanishPermissionType type) async {
    if (kIsWeb) {
      // Simulate/mock behavior for Web in development environment
      final status = _cache[type] ?? VanishPermissionStatus.granted;
      _cache[type] = status;
      return status;
    }

    Permission permission;
    switch (type) {
      case VanishPermissionType.notification:
        permission = Permission.notification;
        break;
      case VanishPermissionType.microphone:
        permission = Permission.microphone;
        break;
      case VanishPermissionType.camera:
        permission = Permission.camera;
        break;
    }

    final status = await permission.status;
    final mapped = _mapStatus(status);
    _cache[type] = mapped;
    return mapped;
  }

  @override
  Future<VanishPermissionStatus> requestPermission(VanishPermissionType type) async {
    if (kIsWeb) {
      // For web, assume granted when requested for testing/mocking
      _cache[type] = VanishPermissionStatus.granted;
      _permissionStreamController.add(Map.from(_cache));
      return VanishPermissionStatus.granted;
    }

    Permission permission;
    switch (type) {
      case VanishPermissionType.notification:
        permission = Permission.notification;
        break;
      case VanishPermissionType.microphone:
        permission = Permission.microphone;
        break;
      case VanishPermissionType.camera:
        permission = Permission.camera;
        break;
    }

    final status = await permission.request();
    final mapped = _mapStatus(status);
    _cache[type] = mapped;
    _permissionStreamController.add(Map.from(_cache));
    return mapped;
  }

  @override
  Future<bool> openSettings() async {
    if (kIsWeb) return false;
    return openAppSettings();
  }

  @override
  Future<void> recheckAll() async {
    for (final type in VanishPermissionType.values) {
      await checkPermissionStatus(type);
    }
    _permissionStreamController.add(Map.from(_cache));
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  @override
  bool isOnboardingCompletedSync() {
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  @override
  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingKey, true);
  }

  VanishPermissionStatus _mapStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return VanishPermissionStatus.granted;
      case PermissionStatus.denied:
        return VanishPermissionStatus.denied;
      case PermissionStatus.permanentlyDenied:
        return VanishPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        return VanishPermissionStatus.restricted;
      default:
        return VanishPermissionStatus.denied;
    }
  }
}
