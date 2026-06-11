import 'package:flutter/material.dart';
import 'package:vanish_link/core/theme/app_theme.dart';

class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Glowing Icon Wrapper with Radial Gradient background
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors.primary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                  radius: 0.8,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.card,
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.1),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      context.appGradients.purpleRose.createShader(bounds),
                  child: Icon(icon, size: 48, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: typography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: typography.bodyMedium.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
