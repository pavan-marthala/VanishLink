import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/sized_context.dart';

class AppMessageInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback onSend;
  final VoidCallback onAttachPressed;
  final VoidCallback onEmojiPressed;
  final String hintText;
  final bool showBottomPadding;

  const AppMessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachPressed,
    required this.onEmojiPressed,
    this.onSubmitted,
    this.hintText = 'Type a secure message...',
    this.showBottomPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        // top: 12,
        bottom: context.isDesktop ? 12 : context.viewInsets.bottom + 90,
      ),
      margin: const EdgeInsets.all(0),
      child: Row(
        spacing: 12,
        children: [
          // Attachment Button
          GestureDetector(
            onTap: onAttachPressed,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.background.withValues(alpha: 0.75),
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.border),
                  ),
                  child: Icon(
                    CupertinoIcons.paperclip,
                    color: colors.textSecondary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          // Text Input Area + Emoji Button
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.background.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colors.border),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: onEmojiPressed,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.smiley,
                            color: colors.textTertiary,
                            size: 20,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: controller,
                          style: typography.bodyMedium.copyWith(
                            color: colors.textPrimary,
                          ),
                          onSubmitted: onSubmitted,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: typography.bodyMedium.copyWith(
                              color: colors.textTertiary,
                            ),
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Send Button
          GestureDetector(
            onTap: onSend,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: context.appGradients.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.paperplane_fill,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
