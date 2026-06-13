import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/services/permission_manager.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/app_toast.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final _permissionManager = getIt<PermissionManager>();
  StreamSubscription? _subscription;
  Map<VanishPermissionType, VanishPermissionStatus> _statuses = {};

  @override
  void initState() {
    super.initState();
    _subscription = _permissionManager.permissionStream.listen((statusMap) {
      if (mounted) {
        setState(() {
          _statuses = statusMap;
        });
      }
    });
    _permissionManager.recheckAll();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  String _getPermissionLabel(VanishPermissionType type) {
    switch (type) {
      case VanishPermissionType.notification:
        return 'Notifications';
      case VanishPermissionType.microphone:
        return 'Microphone';
      case VanishPermissionType.camera:
        return 'Camera (Deferred)';
    }
  }

  String _getPermissionDescription(VanishPermissionType type) {
    switch (type) {
      case VanishPermissionType.notification:
        return 'Used to deliver call alerts, messages, and missed call alerts.';
      case VanishPermissionType.microphone:
        return 'Required to capture your voice during audio and video calls.';
      case VanishPermissionType.camera:
        return 'Used for video calls. Requested only when video is active.';
    }
  }

  IconData _getPermissionIcon(VanishPermissionType type) {
    switch (type) {
      case VanishPermissionType.notification:
        return CupertinoIcons.bell_fill;
      case VanishPermissionType.microphone:
        return CupertinoIcons.mic_fill;
      case VanishPermissionType.camera:
        return CupertinoIcons.videocam_fill;
    }
  }

  Widget _buildStatusBadge(BuildContext context, VanishPermissionStatus status) {
    final colors = context.appColors;
    final typography = context.appTypography;

    String text;
    Color bgColor;
    Color textColor;

    switch (status) {
      case VanishPermissionStatus.granted:
        text = 'Granted';
        bgColor = colors.success.withValues(alpha: 0.1);
        textColor = colors.success;
        break;
      case VanishPermissionStatus.denied:
        text = 'Denied';
        bgColor = colors.error.withValues(alpha: 0.1);
        textColor = colors.error;
        break;
      case VanishPermissionStatus.permanentlyDenied:
        text = 'Permanently Denied';
        bgColor = colors.error.withValues(alpha: 0.15);
        textColor = colors.error;
        break;
      case VanishPermissionStatus.restricted:
        text = 'Restricted';
        bgColor = colors.warning.withValues(alpha: 0.1);
        textColor = colors.warning;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: typography.bodySmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: colors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Permissions',
          style: typography.titleMedium.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Permissions',
                style: typography.titleLarge.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Review and manage permissions required for calling and background notifications.',
                style: typography.bodyMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: VanishPermissionType.values.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final type = VanishPermissionType.values[index];
                    final status = _statuses[type] ?? VanishPermissionStatus.denied;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colors.border.withValues(alpha: context.isDark ? 0.3 : 0.5),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(alpha: 0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getPermissionIcon(type),
                                  color: colors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _getPermissionLabel(type),
                                  style: typography.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              _buildStatusBadge(context, status),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _getPermissionDescription(type),
                            style: typography.bodySmall.copyWith(
                              color: colors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.primary,
                        side: BorderSide(color: colors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        _permissionManager.recheckAll();
                        showSuccessToast(message: 'Permissions re-checked!');
                      },
                      child: const Text('Re-check Status'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        _permissionManager.openSettings();
                      },
                      child: const Text('Open Settings'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
