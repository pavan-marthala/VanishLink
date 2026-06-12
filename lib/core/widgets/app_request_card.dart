import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/theme/app_colors.dart';
import 'package:vanish_link/core/theme/app_typography.dart';
import 'package:vanish_link/features/request/domain/entities/friend_request.dart';

class AppRequestCard extends StatelessWidget {
  final FriendRequest request;
  final bool isIncoming;
  final bool isProcessing;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onCancel;
  final Widget? presenceWidget; // Optional presence widget to show real presence status

  const AppRequestCard({
    super.key,
    required this.request,
    required this.isIncoming,
    required this.isProcessing,
    required this.onAccept,
    required this.onDecline,
    required this.onCancel,
    this.presenceWidget,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    final user = isIncoming ? request.senderProfile : request.receiverProfile;
    if (user == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.border.withValues(alpha: context.isDark ? 0.3 : 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: context.isDark ? 0.2 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.primary.withValues(alpha: 0.15),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: user.photoUrl.isNotEmpty ? NetworkImage(user.photoUrl) : null,
                  backgroundColor: colors.primary.withValues(alpha: 0.08),
                  child: user.photoUrl.isEmpty
                      ? Icon(
                          Icons.person_rounded,
                          color: colors.primary,
                          size: 24,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              // Name Block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: typography.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@${user.username}',
                      style: typography.bodyMedium.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (!isIncoming)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.warning.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colors.warning.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    'Pending',
                    style: typography.bodySmall.copyWith(
                      color: colors.warning,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // User Status / Presence Row
          presenceWidget ??
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getStatusColor(colors, user.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      user.status,
                      style: typography.bodySmall.copyWith(
                        color: colors.textTertiary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
          const SizedBox(height: 16),
          // Action Buttons
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isProcessing
                ? SizedBox(
                    height: 36,
                    child: Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.primary,
                        ),
                      ),
                    ),
                  )
                : _buildActions(context, colors, typography),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(AppColors colors, String status) {
    switch (status.toLowerCase()) {
      case 'available':
      case 'online':
        return colors.success;
      case 'busy':
      case 'dnd':
      case 'do not disturb':
        return colors.error;
      case 'away':
      case 'idle':
        return colors.warning;
      default:
        return colors.inActiveStatus;
    }
  }

  Widget _buildActions(BuildContext context, AppColors colors, AppTypography typography) {
    if (isIncoming) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                Future.delayed(const Duration(milliseconds: 50), () {
                  HapticFeedback.lightImpact();
                });
                onAccept();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: context.appGradients.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                     'Accept',
                    style: typography.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                onDecline();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: colors.border.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Decline',
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onCancel();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: colors.error.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.error.withValues(alpha: 0.2),
            ),
          ),
          child: Center(
            child: Text(
              'Cancel Request',
              style: typography.bodyMedium.copyWith(
                color: colors.error,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
      );
    }
  }
}
