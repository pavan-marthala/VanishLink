import 'package:flutter/material.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/presentation/widgets/call_widgets.dart';

class IncomingCallView extends StatelessWidget {
  final UserProfile? contact;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const IncomingCallView({
    super.key,
    required this.contact,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 64,
            backgroundImage: contact?.photoUrl.isNotEmpty == true
                ? NetworkImage(contact!.photoUrl)
                : null,
            backgroundColor: colors.primary.withValues(alpha: 0.08),
            child: contact?.photoUrl.isNotEmpty != true
                ? Icon(
                    Icons.person_rounded,
                    color: colors.primary,
                    size: 64,
                  )
                : null,
          ),
          const SizedBox(height: 24),
          Text(
            contact?.displayName ?? contact?.username ?? 'VanishLink User',
            style: typography.titleLarge.copyWith(
              color: colors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Incoming Voice Call...',
            style: typography.bodyMedium.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CallActionButton(
                icon: Icons.call_end_rounded,
                backgroundColor: colors.error,
                iconColor: colors.white,
                onTap: onDecline,
                label: 'Decline',
              ),
              CallActionButton(
                icon: Icons.call_rounded,
                backgroundColor: colors.success,
                iconColor: colors.white,
                onTap: onAccept,
                label: 'Accept',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
