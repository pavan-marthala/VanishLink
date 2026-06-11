import 'package:flutter/services.dart';

class AppHaptics {
  /// Triggered on validation errors (medium impact)
  static Future<void> validationError() async {
    await HapticFeedback.mediumImpact();
  }

  /// Triggered on successful signup or login actions
  static Future<void> success() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.lightImpact();
  }
}
