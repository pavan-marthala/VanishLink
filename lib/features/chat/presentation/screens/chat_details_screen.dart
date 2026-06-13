import 'dart:async';
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
import 'package:vanish_link/core/widgets/app_search_field.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/features/chat/presentation/widgets/presence_indicator.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/core/utils/chat_utils.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';
import 'package:vanish_link/core/theme/app_typography.dart';
import 'package:vanish_link/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:vanish_link/features/chat/domain/services/call_coordinator.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';

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
  final GlobalKey<_ChatDetailsBodyState> _bodyKey =
      GlobalKey<_ChatDetailsBodyState>();

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
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        // Details Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                contact.displayName.isNotEmpty
                                    ? contact.displayName
                                    : contact.username,
                                style: typography.titleMedium.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.bold,
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
            icon: Icon(CupertinoIcons.search, color: colors.textPrimary),
            onPressed: () {
              _bodyKey.currentState?.toggleSearch();
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.phone, color: colors.textPrimary),
            onPressed: () {
              if (contactUserId != null && currentUserId.isNotEmpty) {
                getIt<CallCoordinator>().initiateCall(
                  callerId: currentUserId,
                  receiverId: contactUserId,
                  type: CallType.audio,
                );
              }
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.video_camera, color: colors.textPrimary),
            onPressed: () {
              if (contactUserId != null && currentUserId.isNotEmpty) {
                getIt<CallCoordinator>().initiateCall(
                  callerId: currentUserId,
                  receiverId: contactUserId,
                  type: CallType.video,
                );
              }
            },
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
                key: _bodyKey,
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
    super.key,
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
  final Map<String, GlobalKey> _messageKeys = {};

  // Typing
  Timer? _typingTimer;
  bool _isTyping = false;

  // Search
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> _matchingMessageIds = [];
  int _currentMatchIndex = -1;

  // Replies & Edits
  Message? _replyToMessage;
  Message? _editMessage;

  @override
  void initState() {
    super.initState();
    widget.messageController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = widget.messageController.text;
    if (text.isNotEmpty && !_isTyping) {
      _isTyping = true;
      context.read<MessageBloc>().add(
        const MessageEvent.setTyping(isTyping: true),
      );
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 1500), () {
      if (_isTyping) {
        _isTyping = false;
        context.read<MessageBloc>().add(
          const MessageEvent.setTyping(isTyping: false),
        );
      }
    });
  }

  void toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _matchingMessageIds.clear();
        _currentMatchIndex = -1;
      }
    });
  }

  void _sendMessage() {
    final text = widget.messageController.text.trim();
    if (text.isEmpty) return;

    if (_editMessage != null) {
      context.read<MessageBloc>().add(
        MessageEvent.editMessage(
          messageId: _editMessage!.messageId,
          newContent: text,
        ),
      );
      setState(() => _editMessage = null);
    } else {
      context.read<MessageBloc>().add(
        MessageEvent.sendMessage(
          content: text,
          replyToMessageId: _replyToMessage?.messageId,
          replyToSenderId: _replyToMessage?.senderId,
          replyToPreview: _replyToMessage?.content,
        ),
      );
      setState(() => _replyToMessage = null);
    }
    widget.messageController.clear();
    HapticFeedback.lightImpact();
  }

  void _onSearchChanged(String query, List<Message> allMessages) {
    if (query.trim().isEmpty) {
      setState(() {
        _matchingMessageIds.clear();
        _currentMatchIndex = -1;
      });
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final matches = allMessages
        .where((msg) {
          final contentMatch = msg.content.toLowerCase().contains(
            lowercaseQuery,
          );
          final replyMatch =
              msg.replyToPreview?.toLowerCase().contains(lowercaseQuery) ??
              false;
          return contentMatch || replyMatch;
        })
        .map((msg) => msg.messageId)
        .toList();

    setState(() {
      _matchingMessageIds = matches;
      _currentMatchIndex = matches.isNotEmpty ? 0 : -1;
    });

    if (matches.isNotEmpty) {
      _scrollToMatch(matches[0], allMessages);
    }
  }

  void _scrollToMatch(String messageId, List<Message> allMessages) {
    final index = allMessages.indexWhere((m) => m.messageId == messageId);
    if (index == -1) return;

    final key = _messageKeys[messageId];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 300),
        alignment: 0.5,
      );
    } else {
      final approxOffset = index * 85.0;
      if (_scrollController.hasClients) {
        _scrollController
            .animateTo(
              approxOffset,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            )
            .then((_) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (key != null && key.currentContext != null) {
                  Scrollable.ensureVisible(
                    key.currentContext!,
                    duration: const Duration(milliseconds: 200),
                    alignment: 0.5,
                  );
                }
              });
            });
      }
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

  void _showMessageActions(BuildContext context, Message message, bool isMe) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final currentUserId = getIt<FirebaseAuth>().currentUser?.uid ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['👍', '❤️', '😂', '😮', '🔥'].map((emoji) {
                      final hasReacted =
                          message.reactions[currentUserId] == emoji;
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(bottomSheetContext);
                          context.read<MessageBloc>().add(
                            MessageEvent.updateReaction(
                              messageId: message.messageId,
                              reaction: hasReacted ? null : emoji,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: hasReacted
                                ? colors.primary.withValues(alpha: 0.15)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.reply,
                    color: colors.textPrimary,
                  ),
                  title: Text(
                    'Reply',
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    setState(() {
                      _replyToMessage = message;
                      _editMessage = null;
                      widget.messageController.text = "";
                    });
                  },
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.doc_on_doc,
                    color: colors.textPrimary,
                  ),
                  title: Text(
                    'Copy Text',
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    Clipboard.setData(ClipboardData(text: message.content));
                    showSuccessToast(message: 'Copied to clipboard');
                  },
                ),
                if (isMe && !message.isDeleted) ...[
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.pencil,
                      color: colors.textPrimary,
                    ),
                    title: Text(
                      'Edit Message',
                      style: typography.bodyMedium.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(bottomSheetContext);
                      setState(() {
                        _editMessage = message;
                        _replyToMessage = null;
                        widget.messageController.text = message.content;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.trash, color: colors.error),
                    title: Text(
                      'Delete for Everyone',
                      style: typography.bodyMedium.copyWith(
                        color: colors.error,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(bottomSheetContext);
                      context.read<MessageBloc>().add(
                        MessageEvent.deleteMessage(
                          messageId: message.messageId,
                          forEveryone: true,
                        ),
                      );
                    },
                  ),
                ],
                ListTile(
                  leading: Icon(CupertinoIcons.trash, color: colors.error),
                  title: Text(
                    'Delete for Me',
                    style: typography.bodyMedium.copyWith(color: colors.error),
                  ),
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    context.read<MessageBloc>().add(
                      MessageEvent.deleteMessage(
                        messageId: message.messageId,
                        forEveryone: false,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _typingTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final currentUserId = getIt<FirebaseAuth>().currentUser?.uid ?? '';

    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        final List<Message> allMessages = state.maybeMap(
          loaded: (s) => s.messages,
          orElse: () => <Message>[],
        );

        final List<String> typingUsers = state.maybeMap(
          loaded: (s) => s.typingUsers,
          orElse: () => <String>[],
        );

        return Column(
          children: [
            if (_isSearching) _buildSearchBar(colors, typography, allMessages),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  state.map(
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
                          bottom:
                              (context.isDesktop
                                  ? 80
                                  : context.viewInsets.bottom + 170) +
                              (_replyToMessage != null || _editMessage != null
                                  ? 60
                                  : 0),
                        ),
                        itemCount: reversedMessages.length,
                        itemBuilder: (context, index) {
                          final message = reversedMessages[index];
                          final isMe = message.senderId == currentUserId;

                          final key = _messageKeys.putIfAbsent(
                            message.messageId,
                            () => GlobalKey(),
                          );

                          final isHighlighted =
                              _isSearching &&
                              _matchingMessageIds.contains(message.messageId);
                          final isCurrentMatch =
                              _isSearching &&
                              _matchingMessageIds.isNotEmpty &&
                              _currentMatchIndex >= 0 &&
                              _currentMatchIndex < _matchingMessageIds.length &&
                              _matchingMessageIds[_currentMatchIndex] ==
                                  message.messageId;

                          return _MessageBubble(
                            key: key,
                            message: message,
                            isMe: isMe,
                            isHighlighted: isHighlighted,
                            isCurrentMatch: isCurrentMatch,
                            searchQuery: _searchController.text,
                            onLongPress: () =>
                                _showMessageActions(context, message, isMe),
                          );
                        },
                      );
                    },
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_replyToMessage != null)
                          _buildReplyPreviewBanner(
                            colors,
                            typography,
                            currentUserId,
                          ),
                        if (_editMessage != null)
                          _buildEditPreviewBanner(colors, typography),
                        if (typingUsers.isNotEmpty)
                          _buildTypingIndicator(colors, typography),
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
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(
    AppColors colors,
    AppTypography typography,
    List<Message> allMessages,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border(
          bottom: BorderSide(color: colors.border.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.textPrimary),
            onPressed: () {
              setState(() {
                _isSearching = false;
                _searchController.clear();
                _matchingMessageIds.clear();
                _currentMatchIndex = -1;
              });
            },
          ),
          Expanded(
            child: AppSearchField(
              controller: _searchController,
              hintText: 'Search in conversation...',
              onChanged: (query) => _onSearchChanged(query, allMessages),
              onClear: () {
                setState(() {
                  _matchingMessageIds.clear();
                  _currentMatchIndex = -1;
                });
              },
            ),
          ),
          if (_matchingMessageIds.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              '${_currentMatchIndex + 1}/${_matchingMessageIds.length}',
              style: typography.bodySmall.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(CupertinoIcons.chevron_up, color: colors.textPrimary),
              onPressed: () {
                if (_matchingMessageIds.isEmpty) return;
                setState(() {
                  _currentMatchIndex =
                      (_currentMatchIndex - 1 + _matchingMessageIds.length) %
                      _matchingMessageIds.length;
                });
                _scrollToMatch(
                  _matchingMessageIds[_currentMatchIndex],
                  allMessages,
                );
              },
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.chevron_down,
                color: colors.textPrimary,
              ),
              onPressed: () {
                if (_matchingMessageIds.isEmpty) return;
                setState(() {
                  _currentMatchIndex =
                      (_currentMatchIndex + 1) % _matchingMessageIds.length;
                });
                _scrollToMatch(
                  _matchingMessageIds[_currentMatchIndex],
                  allMessages,
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReplyPreviewBanner(
    AppColors colors,
    AppTypography typography,
    String currentUserId,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.reply, size: 16, color: colors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _replyToMessage!.senderId == currentUserId
                      ? 'Replying to yourself'
                      : 'Replying to contact',
                  style: typography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                Text(
                  _replyToMessage!.content,
                  style: typography.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => setState(() => _replyToMessage = null),
          ),
        ],
      ),
    );
  }

  Widget _buildEditPreviewBanner(AppColors colors, AppTypography typography) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.pencil, size: 16, color: colors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Editing message',
                  style: typography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                Text(
                  _editMessage!.content,
                  style: typography.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () {
              setState(() {
                _editMessage = null;
                widget.messageController.text = "";
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(AppColors colors, AppTypography typography) {
    final displayName = widget.contact?.displayName ?? 'Someone';
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$displayName is typing...',
            style: typography.bodySmall.copyWith(
              color: colors.textTertiary,
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        ],
      ),
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
  final bool isHighlighted;
  final bool isCurrentMatch;
  final String? searchQuery;
  final VoidCallback onLongPress;

  const _MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.isHighlighted,
    required this.isCurrentMatch,
    this.searchQuery,
    required this.onLongPress,
  });

  List<TextSpan> _highlightSpans(
    String text,
    String query,
    TextStyle baseStyle,
    TextStyle highlightStyle,
  ) {
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    final List<TextSpan> spans = [];
    final lowercaseText = text.toLowerCase();
    final lowercaseQuery = query.toLowerCase();

    int start = 0;
    int indexOf = lowercaseText.indexOf(lowercaseQuery, start);

    while (indexOf != -1) {
      if (indexOf > start) {
        spans.add(
          TextSpan(text: text.substring(start, indexOf), style: baseStyle),
        );
      }
      spans.add(
        TextSpan(
          text: text.substring(indexOf, indexOf + query.length),
          style: highlightStyle,
        ),
      );
      start = indexOf + query.length;
      indexOf = lowercaseText.indexOf(lowercaseQuery, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: baseStyle));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final timeStr = formatCompactTimestamp(message.createdAt);
    final isFailed = message.status == 'failed';

    Widget bubbleContent = Container(
      margin: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: isMe ? 64 : 16,
        right: isMe ? 16 : 64,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isMe
            ? (isFailed ? colors.error.withValues(alpha: 0.12) : null)
            : colors.card,
        gradient: isMe && !isFailed ? context.appGradients.purpleRose : null,
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
        border: isCurrentMatch
            ? Border.all(color: Colors.amber, width: 2.0)
            : isHighlighted
            ? Border.all(color: colors.primary, width: 1.5)
            : isMe
            ? (isFailed
                  ? Border.all(
                      color: colors.error.withValues(alpha: 0.4),
                      width: 1.5,
                    )
                  : null)
            : Border.all(color: colors.border.withValues(alpha: 0.5), width: 1),
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
          if (message.replyToMessageId != null)
            _buildReplyPreview(colors, typography),
          if (searchQuery == null || searchQuery!.isEmpty)
            Text(
              message.content,
              style: typography.bodyMedium.copyWith(
                color: isMe
                    ? (isFailed ? colors.textPrimary : Colors.white)
                    : colors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: message.isDeleted
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            )
          else
            RichText(
              text: TextSpan(
                children: _highlightSpans(
                  message.content,
                  searchQuery!,
                  typography.bodyMedium.copyWith(
                    color: isMe
                        ? (isFailed ? colors.textPrimary : Colors.white)
                        : colors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: message.isDeleted
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                  typography.bodyMedium.copyWith(
                    color: Colors.black,
                    backgroundColor: Colors.yellowAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          if (message.reactions.isNotEmpty) ...[
            const SizedBox(height: 6),
            _buildReactions(colors, typography),
          ],
        ],
      ),
    );

    if (isFailed) {
      return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            context.read<MessageBloc>().add(MessageEvent.retryMessage(message));
          },
          child: bubbleContent,
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        onSecondaryTap: onLongPress,
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            bubbleContent,

            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (message.edited) ...[
                  Text(
                    ' (edited)',
                    style: typography.bodySmall.copyWith(
                      color: isMe ? Colors.white70 : colors.textTertiary,
                      fontSize: 8,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                if (isFailed) ...[
                  Text(
                    'Failed to send. Tap to retry',
                    style: typography.bodySmall.copyWith(
                      color: colors.error,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                ] else ...[
                  Text(
                    timeStr,
                    style: typography.bodySmall.copyWith(
                      color: isMe ? colors.textPrimary : colors.textTertiary,
                      fontSize: 8,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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

  Widget _buildReplyPreview(AppColors colors, AppTypography typography) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isMe
            ? Colors.black.withValues(alpha: 0.15)
            : colors.background.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: isMe ? Colors.white70 : colors.primary,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.replyToSenderId == message.senderId
                ? 'Reply to self'
                : 'Reply',
            style: typography.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: isMe ? Colors.white : colors.primary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.replyToPreview ?? '',
            style: typography.bodySmall.copyWith(
              color: isMe
                  ? Colors.white.withValues(alpha: 0.9)
                  : colors.textSecondary,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildReactions(AppColors colors, AppTypography typography) {
    final emojiGroups = <String, List<String>>{};
    message.reactions.forEach((userId, emoji) {
      emojiGroups.putIfAbsent(emoji, () => []).add(userId);
    });

    return Wrap(
      spacing: 4,
      children: emojiGroups.entries.map((entry) {
        final emoji = entry.key;
        final count = entry.value.length;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.black.withValues(alpha: 0.1)
                : colors.background.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isMe
                  ? Colors.white24
                  : colors.border.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 11)),
              if (count > 1) ...[
                const SizedBox(width: 2),
                Text(
                  '$count',
                  style: typography.bodySmall.copyWith(
                    fontSize: 9,
                    color: isMe ? Colors.white70 : colors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
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

    if (message.status == 'failed') {
      return Icon(Icons.error_outline_rounded, size: 13, color: colors.error);
    }

    final isRead = message.status == 'read';
    final isDelivered = message.status == 'delivered' || isRead;

    return Icon(
      isDelivered ? Icons.done_all : Icons.check,
      size: 13,
      color: isRead ? const Color(0xFF80D8FF) : Colors.white70,
    );
  }
}
