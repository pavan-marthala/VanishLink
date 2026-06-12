import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vanish_link/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatelessWidget {
  const _ProfileScreenContent();

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    HapticFeedback.lightImpact();
    showSuccessToast(message: 'Vanish ID copied to clipboard!');
  }

  void _showLogoutDialog(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Log Out',
          style: typography.titleMedium.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to log out of VanishLink? Your active session will be closed.',
          style: typography.bodyMedium.copyWith(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: typography.bodyMedium.copyWith(color: colors.textTertiary, fontWeight: FontWeight.w600),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text(
              'Log Out',
              style: typography.bodyMedium.copyWith(color: colors.error, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(ctx).pop();
              context.read<AuthBloc>().add(const AuthEvent.signOutRequested());
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'About VanishLink',
          style: typography.titleMedium.copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0 (Beta 2026)', style: typography.bodyMedium.copyWith(color: colors.textPrimary)),
            const SizedBox(height: 8),
            Text(
              'VanishLink is an ephemeral and secure messaging platform preparing for future WebRTC peer-to-peer audio/video and encryption layers.',
              style: typography.bodySmall.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: 12),
            Text('© 2026 VanishLink Team', style: typography.bodySmall.copyWith(color: colors.textTertiary)),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Close', style: typography.bodyMedium.copyWith(color: colors.primary, fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const Center(child: CircularProgressIndicator()),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              error: (s) => Center(
                child: Text(
                  s.message,
                  style: typography.bodyMedium.copyWith(color: colors.error),
                ),
              ),
              loaded: (s) {
                final profile = s.profile;
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Screen Header
                      Text(
                        'Profile',
                        style: typography.titleLarge.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colors.textPrimary,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Premium Profile Hero Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: context.appGradients.purpleRose,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: colors.primary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Large Avatar with Glow border
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colors.white.withValues(alpha: 0.3),
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.black.withValues(alpha: 0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 48,
                                backgroundImage: profile.photoUrl.isNotEmpty
                                    ? NetworkImage(profile.photoUrl)
                                    : null,
                                backgroundColor: colors.white.withValues(alpha: 0.1),
                                child: profile.photoUrl.isEmpty
                                    ? Icon(Icons.person_rounded, color: colors.white, size: 48)
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Display Name
                            Text(
                              profile.displayName,
                              style: typography.titleMedium.copyWith(
                                color: colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            // Username
                            Text(
                              '@${profile.username}',
                              style: typography.bodyMedium.copyWith(
                                color: colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            // Vanish ID Capsule Badge
                            GestureDetector(
                              onTap: () => _copyToClipboard(profile.vanishId),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: colors.black.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      profile.vanishId,
                                      style: typography.bodySmall.copyWith(
                                        color: colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.copy_rounded,
                                      color: colors.white.withValues(alpha: 0.8),
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Status Banner
                            BlocProvider<PresenceBloc>(
                              create: (context) => getIt<PresenceBloc>()..add(PresenceEvent.monitorUser(profile.userId)),
                              child: BlocBuilder<PresenceBloc, PresenceState>(
                                builder: (context, presenceState) {
                                  final isOnline = presenceState.isOnline;
                                  final presenceText = presenceState.displayStatus;

                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: colors.white.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: isOnline ? colors.success : colors.inActiveStatus,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            presenceText,
                                            style: typography.bodySmall.copyWith(
                                              color: colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Settings Sections
                      _buildSectionHeader('Account'),
                      _buildSettingsTile(
                        icon: CupertinoIcons.person_crop_circle_fill,
                        title: 'Edit Profile',
                        subtitle: 'Change your display name and status',
                        onTap: () {
                          HapticFeedback.lightImpact();
                          context.push(AppRoutes.profileEdit);
                        },
                      ),
                      const SizedBox(height: 20),

                      _buildSectionHeader('Preferences'),
                      _buildSettingsTile(
                        icon: CupertinoIcons.lock_shield_fill,
                        title: 'Privacy Settings',
                        subtitle: 'Ephemeral storage and keys',
                        onTap: () {
                          HapticFeedback.lightImpact();
                          showInfoToast(message: 'Privacy settings coming soon!');
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsTile(
                        icon: CupertinoIcons.bell_fill,
                        title: 'Notifications',
                        subtitle: 'Mute sounds, banners and preview settings',
                        onTap: () {
                          HapticFeedback.lightImpact();
                          showInfoToast(message: 'Notification settings coming soon!');
                        },
                      ),
                      const SizedBox(height: 20),

                      _buildSectionHeader('Application'),
                      _buildSettingsTile(
                        icon: CupertinoIcons.info_circle_fill,
                        title: 'About VanishLink',
                        subtitle: 'App version, licensing, and security protocol',
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _showAboutDialog(context);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsTile(
                        icon: Icons.logout_rounded,
                        title: 'Log Out',
                        subtitle: 'Sign out of your active account',
                        iconColor: colors.error,
                        titleColor: colors.error,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Builder(builder: (context) {
      final colors = context.appColors;
      final typography = context.appTypography;
      return Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(
          title.toUpperCase(),
          style: typography.labelSmall.copyWith(
            color: colors.textTertiary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      );
    });
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return Builder(builder: (context) {
      final colors = context.appColors;
      final typography = context.appTypography;

      return Container(
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.border.withValues(alpha: context.isDark ? 0.3 : 0.5),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (iconColor ?? colors.primary).withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? colors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: typography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: titleColor ?? colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: typography.bodySmall.copyWith(
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_forward,
                      color: colors.textTertiary,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
