import 'package:flutter/material.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/dimens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final gradients = context.appGradients;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: context.isDark
              ? gradients.backgroundDark
              : gradients.backgroundLight,
        ),
        child: Stack(
          children: [
            // Decorative background glow - Top Right
            Positioned(
              top: -150,
              right: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.25),
                      blurRadius: 150,
                      spreadRadius: 80,
                    ),
                  ],
                ),
              ),
            ),

            // Decorative background glow - Bottom Left
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors.secondary.withValues(alpha: 0.2),
                      blurRadius: 120,
                      spreadRadius: 60,
                    ),
                  ],
                ),
              ),
            ),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Glowing Brand Logo Container
                  Container(
                    padding: const EdgeInsets.all(Dimens.veryLargePadding),
                    decoration: BoxDecoration(
                      color: colors.card.withValues(
                        alpha: context.isDark ? 0.4 : 0.8,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.15),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          gradients.purpleRose.createShader(bounds),
                      child: Icon(
                        Icons.link_off_rounded,
                        size: 72,
                        color: colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.veryLargePadding),

                  // App Name
                  Text(
                    'VanishLink',
                    style: typography.displaySmall.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: Dimens.smallPadding),

                  // App Slogan
                  Text(
                    'Ephemeral, secure, vanishing links',
                    style: typography.bodySmall.copyWith(
                      color: colors.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Loading Indicator at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: Dimens.extraLargePadding * 2,
                ),
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
