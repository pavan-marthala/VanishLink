import 'package:flutter/material.dart';
import 'package:vanish_link/core/theme/app_theme.dart';

class CallActionButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;
  final String label;
  final double size;

  const CallActionButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    required this.label,
    this.size = 64.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: size * 0.45,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.appColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class CallStatusIndicator extends StatefulWidget {
  final String status;

  const CallStatusIndicator({
    super.key,
    required this.status,
  });

  @override
  State<CallStatusIndicator> createState() => _CallStatusIndicatorState();
}

class _CallStatusIndicatorState extends State<CallStatusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    String text = '';
    Color color = colors.textSecondary;
    bool animate = false;

    switch (widget.status) {
      case 'created':
      case 'delivering':
        text = 'Dialing...';
        animate = true;
        break;
      case 'calling':
        text = 'Calling...';
        animate = true;
        break;
      case 'ringing':
        text = 'Ringing...';
        animate = true;
        break;
      case 'accepted':
      case 'connected':
        text = 'Connected';
        color = colors.success;
        break;
      case 'declined':
        text = 'Call Declined';
        color = colors.error;
        break;
      case 'missed':
        text = 'Missed Call';
        color = colors.warning;
        break;
      case 'ended':
        text = 'Call Ended';
        color = colors.error;
        break;
      case 'cancelled':
        text = 'Call Cancelled';
        color = colors.error;
        break;
      default:
        text = widget.status;
    }

    if (!animate) {
      return Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final dots = '.' * ((_controller.value * 3).floor() + 1);
        final baseText = text.replaceAll('...', '');
        return Text(
          '$baseText$dots',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
        );
      },
    );
  }
}
