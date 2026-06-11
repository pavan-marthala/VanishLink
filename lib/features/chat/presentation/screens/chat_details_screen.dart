import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/features/chat/presentation/widgets/presence_indicator.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String? chatId;
  final UserProfile? contact;

  const ChatDetailsScreen({
    super.key,
    this.chatId,
    this.contact,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  UserProfile? _contact;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
    if (_contact == null && widget.chatId != null) {
      _loadContact();
    }
  }

  Future<void> _loadContact() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(widget.chatId).get();
      if (doc.exists && mounted) {
        final data = doc.data();
        if (data != null) {
          setState(() {
            _contact = UserProfile(
              userId: data['userId'] as String? ?? '',
              vanishId: data['vanishId'] as String? ?? '',
              username: data['username'] as String? ?? '',
              displayName: data['displayName'] as String? ?? '',
              photoUrl: data['photoUrl'] as String? ?? '',
              status: data['status'] as String? ?? 'Available',
            );
          });
        }
      }
    } catch (_) {}
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showComingSoon(String action) {
    HapticFeedback.lightImpact();
    if (action == 'send') {
      showInfoToast(message: 'Messaging is coming soon with WebRTC integration!');
    } else {
      showInfoToast(message: 'Media attachment is coming soon in future updates!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    final contact = _contact;
    final isOnline = contact != null && (contact.userId.hashCode % 2 == 0);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.card,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: _isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : contact == null
                ? Text('Chat', style: typography.titleMedium.copyWith(color: colors.textPrimary))
                : Row(
                    children: [
                      // Avatar with presence overlay
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: contact.photoUrl.isNotEmpty
                                ? NetworkImage(contact.photoUrl)
                                : null,
                            backgroundColor: colors.primary.withValues(alpha: 0.08),
                            child: contact.photoUrl.isEmpty
                                ? Icon(Icons.person_rounded, color: colors.primary, size: 20)
                                : null,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: PresenceIndicator(
                              isOnline: isOnline,
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // Details Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              contact.displayName,
                              style: typography.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              contact.status,
                              style: typography.bodySmall.copyWith(
                                color: colors.textTertiary,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.phone, color: colors.textPrimary),
            onPressed: () => showInfoToast(message: 'Voice calls coming soon!'),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.video_camera, color: colors.textPrimary),
            onPressed: () => showInfoToast(message: 'Video calls coming soon!'),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colors.border.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // Message Area Placeholder
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Glowing Icon wrapper
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
                        padding: const EdgeInsets.all(20),
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
                          child: Icon(
                            contact != null ? Icons.lock_outline_rounded : CupertinoIcons.chat_bubble_2_fill,
                            size: 52,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Start Your Conversation',
                      style: typography.titleLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      contact != null
                          ? 'Messages sent to @${contact.username} will be end-to-end encrypted.'
                          : 'Messages will appear here once chat is implemented.',
                      style: typography.bodyMedium.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'VanishLink communication protocol V1',
                      style: typography.bodySmall.copyWith(
                        color: colors.textTertiary,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Message Input Bar
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 10,
              bottom: MediaQuery.of(context).padding.bottom + 10,
            ),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Attachment Button
                GestureDetector(
                  onTap: () => _showComingSoon('attach'),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.background,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.border.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.paperclip,
                      color: colors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Text Input Area
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: colors.border.withValues(alpha: 0.5),
                      ),
                    ),
                    child: TextField(
                      style: typography.bodyMedium.copyWith(color: colors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Type a secure message...',
                        hintStyle: typography.bodyMedium.copyWith(
                          color: colors.textTertiary,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _showComingSoon('send'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Send Button
                GestureDetector(
                  onTap: () => _showComingSoon('send'),
                  child: Container(
                    padding: const EdgeInsets.all(12),
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
          ),
        ],
      ),
    );
  }
}
