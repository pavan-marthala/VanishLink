import 'package:flutter/material.dart';
import 'package:vanish_link/core/theme/app_theme.dart';

class PresenceIndicator extends StatelessWidget {
  final bool isOnline;
  final double size;

  const PresenceIndicator({
    super.key,
    required this.isOnline,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOnline ? colors.activeStatus : colors.inActiveStatus,
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.background,
          width: 1.5,
        ),
      ),
    );
  }
}
