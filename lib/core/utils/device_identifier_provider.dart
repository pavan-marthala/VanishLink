import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class DeviceIdentifierProvider {
  Future<String> getIdentifier();
  Future<String> getPlatform();
}

class DeviceIdentifierProviderImpl implements DeviceIdentifierProvider {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<String> getIdentifier() async {
    String rawId;
    if (kIsWeb) {
      rawId = await _getOrGeneratePersistentUuid();
    } else {
      try {
        if (Platform.isAndroid) {
          final androidInfo = await _deviceInfo.androidInfo;
          rawId = androidInfo.id; // Android ID
        } else if (Platform.isIOS) {
          final iosInfo = await _deviceInfo.iosInfo;
          rawId = iosInfo.identifierForVendor ?? await _getOrGeneratePersistentUuid();
        } else {
          rawId = await _getOrGeneratePersistentUuid();
        }
      } catch (_) {
        rawId = await _getOrGeneratePersistentUuid();
      }
    }

    // Sanitize ID for Firebase RTDB keys (remove/replace '.', '#', '$', '/', '[', ']')
    return rawId.replaceAll(RegExp(r'[\.\#\$\/\[\]]'), '_');
  }

  @override
  Future<String> getPlatform() async {
    if (kIsWeb) return 'web';
    try {
      if (Platform.isAndroid) return 'android';
      if (Platform.isIOS) return 'ios';
      if (Platform.isWindows) return 'windows';
      if (Platform.isMacOS) return 'macos';
      if (Platform.isLinux) return 'linux';
      return Platform.operatingSystem;
    } catch (_) {
      return 'unknown';
    }
  }

  Future<String> _getOrGeneratePersistentUuid() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'vanish_link_persistent_device_id';
    var cachedId = prefs.getString(key);
    if (cachedId == null) {
      cachedId = const Uuid().v4();
      await prefs.setString(key, cachedId);
    }
    return cachedId;
  }
}
