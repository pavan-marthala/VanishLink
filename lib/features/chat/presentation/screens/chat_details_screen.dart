import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/theme/app_colors.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/core/utils/sized_context.dart';
import 'package:vanish_link/core/widgets/app_message_input.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/features/chat/presentation/widgets/presence_indicator.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/core/utils/chat_utils.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';
import 'package:vanish_link/features/chat/presentation/bloc/message/message_bloc.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String? chatId;
  final UserProfile? contact;
  final bool showBackButton;

  const ChatDetailsScreen({
    super.key,
    this.chatId,
    this.contact,
    this.showBackButton = true,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  UserProfile? _contact;
  bool _isLoading = false;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
    if (_contact == null && widget.chatId != null) {
      _loadContact();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatDetailsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.chatId != oldWidget.chatId ||
        widget.contact != oldWidget.contact) {
      setState(() {
        _contact = widget.contact;
      });
      if (_contact == null && widget.chatId != null) {
        _loadContact();
      }
    }
  }

  Future<void> _loadContact() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.chatId)
          .get();
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

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    final contact = _contact;
    final contactUserId = contact?.userId ?? widget.chatId;
    final currentUserId = getIt<FirebaseAuth>().currentUser?.uid ?? '';
    final trueChatId = contactUserId != null
        ? getDeterministicChatId(currentUserId, contactUserId)
        : '';

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.card,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: widget.showBackButton ? 56 : 24,
        leading: widget.showBackButton
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colors.textPrimary,
                  size: 20,
                ),
                onPressed: () => context.pop(),
              )
            : const SizedBox.shrink(),
        titleSpacing: 0,
        title: _isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : contact == null
            ? Text(
                'Chat',
                style: typography.titleMedium.copyWith(
                  color: colors.textPrimary,
                ),
              )
            : BlocProvider<PresenceBloc>(
                create: (context) =>
                    getIt<PresenceBloc>()
                      ..add(PresenceEvent.monitorUser(contact.userId)),
                child: BlocBuilder<PresenceBloc, PresenceState>(
                  builder: (context, presenceState) {
                    final isOnline = presenceState.isOnline;
                    final presenceText = presenceState.displayStatus;

                    return Row(
                      children: [
                        // Avatar with presence overlay
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: contact.photoUrl.isNotEmpty
                                  ? NetworkImage(contact.photoUrl)
                                  : null,
                              backgroundColor: colors.primary.withValues(
                                alpha: 0.08,
                              ),
                              child: contact.photoUrl.isEmpty
                                  ? Icon(
                                      Icons.person_rounded,
                                      color: colors.primary,
                                      size: 20,
                                    )
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
                                presenceText,
                                style: typography.bodySmall.copyWith(
                                  color: isOnline
                                      ? colors.success
                                      : colors.textTertiary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
      body: contactUserId == null
          ? const Center(child: CircularProgressIndicator())
          : BlocProvider<MessageBloc>(
              key: ValueKey(trueChatId),
              create: (context) =>
                  getIt<MessageBloc>()
                    ..add(MessageEvent.loadMessages(trueChatId)),
              child: _ChatDetailsBody(
                contact: contact,
                contactUserId: contactUserId,
                trueChatId: trueChatId,
                messageController: _messageController,
                showBackButton: widget.showBackButton,
              ),
            ),
    );
  }
}

class _ChatDetailsBody extends StatefulWidget {
  final UserProfile? contact;
  final String contactUserId;
  final String trueChatId;
  final TextEditingController messageController;
  final bool showBackButton;

  const _ChatDetailsBody({
    required this.contact,
    required this.contactUserId,
    required this.trueChatId,
    required this.messageController,
    required this.showBackButton,
  });

  @override
  State<_ChatDetailsBody> createState() => _ChatDetailsBodyState();
}

class _ChatDetailsBodyState extends State<_ChatDetailsBody> {
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = widget.messageController.text.trim();
    if (text.isNotEmpty) {
      context.read<MessageBloc>().add(MessageEvent.sendMessage(content: text));
      widget.messageController.clear();
      HapticFeedback.lightImpact();
    }
  }

  void _showComingSoon(String action) {
    HapticFeedback.lightImpact();
    if (action == 'emoji') {
      showInfoToast(message: 'Emojis are coming soon!');
    } else {
      showInfoToast(
        message: 'Media attachment is coming soon in future updates!',
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final currentUserId = getIt<FirebaseAuth>().currentUser?.uid ?? '';

    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: .bottomCenter,
            children: [
              BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  return state.map(
                    initial: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    loading: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    empty: (_) => _buildEmptyState(context),
                    error: (s) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          s.message,
                          style: typography.bodyMedium.copyWith(
                            color: colors.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    loaded: (s) {
                      final reversedMessages = s.messages.reversed.toList();
                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 12,
                          bottom: context.isDesktop
                              ? 80
                              : context.viewInsets.bottom + 170,
                        ),
                        itemCount: reversedMessages.length,
                        itemBuilder: (context, index) {
                          final message = reversedMessages[index];
                          final isMe = message.senderId == currentUserId;

                          return _MessageBubble(
                            message: message,
                            isMe: isMe,
                            key: ValueKey(message.messageId),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              AppMessageInput(
                controller: widget.messageController,
                hintText: widget.contact != null
                    ? 'Message ${widget.contact!.displayName}...'
                    : 'Type a secure message...',
                showBottomPadding: widget.showBackButton,
                onSend: _sendMessage,
                onAttachPressed: () => _showComingSoon('attach'),
                onEmojiPressed: () => _showComingSoon('emoji'),
                onSubmitted: (_) => _sendMessage(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final displayName = widget.contact?.displayName ?? 'User';

    return Center(
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
                  child: const Icon(
                    CupertinoIcons.lock_shield_fill,
                    size: 52,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Start a conversation with $displayName',
              style: typography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'All messages in VanishLink disappear\nautomatically 6 hours after they are sent.',
              style: typography.bodyMedium.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Expiration pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.timer, size: 14, color: colors.primary),
                  const SizedBox(width: 8),
                  Text(
                    '6-Hour Expiration Active',
                    style: typography.bodySmall.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const _MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final timeStr = formatCompactTimestamp(message.createdAt);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: isMe ? 64 : 16,
          right: isMe ? 16 : 64,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? null : colors.card,
          gradient: isMe ? context.appGradients.purpleRose : null,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe
                ? const Radius.circular(16)
                : const Radius.circular(4),
            bottomRight: isMe
                ? const Radius.circular(4)
                : const Radius.circular(16),
          ),
          border: isMe
              ? null
              : Border.all(
                  color: colors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.content,
              style: typography.bodyMedium.copyWith(
                color: isMe ? Colors.white : colors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timeStr,
                  style: typography.bodySmall.copyWith(
                    color: isMe
                        ? Colors.white.withValues(alpha: 0.7)
                        : colors.textTertiary,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  _buildReceiptIcon(colors),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptIcon(AppColors colors) {
    if (message.status == 'sending') {
      return const SizedBox(
        width: 10,
        height: 10,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
        ),
      );
    }

    final isRead = message.status == 'read';
    final isDelivered = message.status == 'delivered' || isRead;

    return Icon(
      isDelivered ? Icons.done_all : Icons.check,
      size: 13,
      color: isRead
          ? const Color(0xFF80D8FF) // Glowing light blue for read
          : Colors.white70,
    );
  }
}
