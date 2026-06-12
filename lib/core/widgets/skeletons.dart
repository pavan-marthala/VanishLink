import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vanish_link/core/theme/app_theme.dart';

/// Skeleton placeholder for a single Contact/Conversation row
class ContactCardSkeleton extends StatelessWidget {
  const ContactCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          const Bone.circle(size: 48),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bone.text(width: 100),
                    Bone.text(width: 40),
                  ],
                ),
                const SizedBox(height: 6),
                Bone.text(width: 70),
                const SizedBox(height: 6),
                Bone.text(width: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton placeholder for a Request Card
class RequestCardSkeleton extends StatelessWidget {
  const RequestCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Bone.circle(size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(width: 120),
                    const SizedBox(height: 6),
                    Bone.text(width: 80),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Bone.circle(size: 8),
              const SizedBox(width: 8),
              Bone.text(width: 100),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Bone.button(height: 36)),
              const SizedBox(width: 12),
              Expanded(child: Bone.button(height: 36)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Skeleton placeholder for a Conversation message thread
class ConversationSkeleton extends StatelessWidget {
  const ConversationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Bone.circle(size: 40),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(width: 80),
                  const SizedBox(height: 4),
                  Bone.text(width: 60),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Bone.text(width: double.infinity),
          const SizedBox(height: 6),
          Bone.text(width: double.infinity),
          const SizedBox(height: 6),
          Bone.text(width: 150),
        ],
      ),
    );
  }
}
