import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/sized_context.dart';
import 'package:vanish_link/core/widgets/app_empty_state.dart';
import 'package:vanish_link/core/widgets/app_search_field.dart';
import 'package:vanish_link/core/widgets/skeletons.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:vanish_link/features/chat/presentation/widgets/presence_indicator.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:vanish_link/core/utils/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';
import 'package:vanish_link/core/utils/chat_utils.dart';
import 'package:vanish_link/features/chat/domain/entities/message.dart';

class ChatScreen extends StatefulWidget {
  final String? selectedChatId;

  const ChatScreen({super.key, this.selectedChatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserProfile? _selectedContact;
  String? _lastResolvedId;

  void _resolveContact(List<UserProfile> contacts) {
    if (widget.selectedChatId != null &&
        widget.selectedChatId != _lastResolvedId) {
      final match = contacts.firstWhereOrNull(
        (c) => c.userId == widget.selectedChatId,
      );
      if (match != null) {
        setState(() {
          _selectedContact = match;
          _lastResolvedId = widget.selectedChatId;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatsBloc>(
      create: (_) => getIt<ChatsBloc>()..add(const ChatsEvent.started()),
      child: BlocListener<ChatsBloc, ChatsState>(
        listener: (context, state) {
          state.mapOrNull(loaded: (s) => _resolveContact(s.allContacts));
        },
        child: _ChatScreenContent(
          selectedChatId: widget.selectedChatId,
          selectedContact: _selectedContact,
          onContactSelected: (contact) {
            setState(() {
              _selectedContact = contact;
              _lastResolvedId = contact.userId;
            });
          },
        ),
      ),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  final String? selectedChatId;
  final UserProfile? selectedContact;
  final ValueChanged<UserProfile> onContactSelected;

  const _ChatScreenContent({
    required this.selectedChatId,
    required this.selectedContact,
    required this.onContactSelected,
  });

  @override
  State<_ChatScreenContent> createState() => _ChatScreenContentState();
}

class _ChatScreenContentState extends State<_ChatScreenContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDesktop = context.isDesktop;
    final isLargeScreen = isDesktop;

    if (isLargeScreen) {
      // Split view layout for tablet and desktop
      final double sidebarWidth = context.widthPx * (isDesktop ? 0.25 : 0.30);
      return Scaffold(
        backgroundColor: colors.background,
        body: Row(
          children: [
            // Left sidebar: integrated header and list
            SizedBox(
              width: sidebarWidth,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: colors.border.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                ),
                child: _buildSidebarList(context, true),
              ),
            ),
            // Right workspace area
            Expanded(
              child: widget.selectedContact == null
                  ? _buildEmptyWorkspace(context)
                  : ChatDetailsScreen(
                      chatId: widget.selectedContact!.userId,
                      contact: widget.selectedContact,
                      showBackButton:
                          false, // Hide back button inside inline split pane
                    ),
            ),
          ],
        ),
      );
    } else {
      // Mobile Layout: Full screen contacts list
      return Scaffold(
        backgroundColor: colors.background,
        body: _buildSidebarList(context, false),
      );
    }
  }

  // Common List panel builder (used in split view or as full screen)
  Widget _buildSidebarList(BuildContext context, bool isSplitView) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Integrated Header Section
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: 8,
            ),
            child: Row(
              children: [
                Text(
                  'Chats',
                  style: typography.titleLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: colors.textPrimary,
                    fontSize: isSplitView ? 24 : 28,
                  ),
                ),
                const SizedBox(width: 8),
                // Chats count badge
                BlocBuilder<ChatsBloc, ChatsState>(
                  builder: (context, state) {
                    return state.maybeMap(
                      loaded: (s) {
                        if (s.allContacts.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${s.allContacts.length}',
                            style: typography.bodySmall.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),

          // Integrated Search capsule
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: AppSearchField(
              controller: _searchController,
              hintText: 'Search conversations...',
              onChanged: (val) {
                context.read<ChatsBloc>().add(
                  ChatsEvent.searchQueryChanged(val),
                );
              },
              onClear: () {
                context.read<ChatsBloc>().add(
                  const ChatsEvent.searchQueryChanged(''),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // List Body
          Expanded(
            child: BlocBuilder<ChatsBloc, ChatsState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) => const SizedBox.shrink(),
                  loading: (_) => Skeletonizer(
                    enabled: true,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 4,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        return const ContactCardSkeleton();
                      },
                    ),
                  ),
                  loaded: (s) {
                    if (s.allContacts.isEmpty) {
                      return AppEmptyState(
                        icon: CupertinoIcons.chat_bubble_2,
                        title: 'No Contacts Yet',
                        subtitle: 'Search users and send connection requests.',
                        action: AppButton(
                          text: 'Discover Users',
                          color: colors.primary,
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            context.push(AppRoutes.discover);
                          },
                        ),
                      );
                    }

                    if (s.filteredContacts.isEmpty) {
                      return const AppEmptyState(
                        icon: Icons.search_off_rounded,
                        title: 'No Results',
                        subtitle: 'Try searching for another user.',
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 4,
                        bottom: 100,
                      ),
                      itemCount: s.filteredContacts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 2),
                      itemBuilder: (context, index) {
                        final contact = s.filteredContacts[index];
                        final isSelected =
                            widget.selectedContact?.userId == contact.userId;

                        return TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 300 + (index * 50)),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: _ConversationRow(
                            contact: contact,
                            isSelected: isSelected,
                            index: index,
                            onTap: () {
                              if (isSplitView) {
                                widget.onContactSelected(contact);
                              } else {
                                HapticFeedback.lightImpact();
                                context.push(
                                  '${AppRoutes.chats}/${contact.userId}',
                                  extra: contact,
                                );
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                  error: (s) => Center(
                    child: Text(
                      s.message,
                      style: typography.bodyMedium.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Premium Select Conversation Placeholder
  Widget _buildEmptyWorkspace(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Container(
      color: colors.background,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glowing Icon Wrapper with Radial Gradient background
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                    radius: 0.8,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.card,
                    border: Border.all(
                      color: colors.border.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.08),
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        context.appGradients.purpleRose.createShader(bounds),
                    child: const Icon(
                      CupertinoIcons.chat_bubble_2_fill,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Select a Conversation',
                style: typography.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose a contact from the sidebar list to start chatting securely.',
                style: typography.bodyMedium.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Security warning footer info
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_user_rounded,
                    size: 14,
                    color: colors.success,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'P2P Encryption Active',
                    style: typography.bodySmall.copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversationRow extends StatefulWidget {
  final UserProfile contact;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const _ConversationRow({
    required this.contact,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  State<_ConversationRow> createState() => _ConversationRowState();
}

class _ConversationRowState extends State<_ConversationRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final currentUserId = getIt<FirebaseAuth>().currentUser?.uid;
    final chatId = getDeterministicChatId(
      currentUserId ?? '',
      widget.contact.userId,
    );

    return BlocProvider<PresenceBloc>(
      create: (context) =>
          getIt<PresenceBloc>()
            ..add(PresenceEvent.monitorUser(widget.contact.userId)),
      child: BlocBuilder<PresenceBloc, PresenceState>(
        builder: (context, presenceState) {
          final isOnline = presenceState.isOnline;

          return StreamBuilder<Message?>(
            stream: getIt<MessageRepository>().watchLastMessage(chatId),
            builder: (context, snapshot) {
              final lastMessage = snapshot.data;
              final lastMsg = lastMessage != null
                  ? lastMessage.content
                  : 'No messages yet';
              final timestamp = lastMessage != null
                  ? formatCompactTimestamp(lastMessage.createdAt)
                  : '';
              final isTyping = isOnline;
              final unreadCount = 0;

              final Color backgroundColor = widget.isSelected
                  ? colors.primary.withValues(alpha: 0.12)
                  : _isHovered
                  ? colors.surfaceDark.withValues(alpha: 0.35)
                  : Colors.transparent;

              return MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.isSelected
                          ? colors.primary.withValues(alpha: 0.25)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        widget.onTap();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundImage:
                                        widget.contact.photoUrl.isNotEmpty
                                        ? NetworkImage(widget.contact.photoUrl)
                                        : null,
                                    backgroundColor: colors.primary.withValues(
                                      alpha: 0.08,
                                    ),
                                    child: widget.contact.photoUrl.isEmpty
                                        ? Icon(
                                            Icons.person_rounded,
                                            color: colors.primary,
                                            size: 24,
                                          )
                                        : null,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: PresenceIndicator(
                                    isOnline: isOnline,
                                    size: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.contact.displayName,
                                          style: typography.bodyLarge.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colors.textPrimary,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (timestamp.isNotEmpty)
                                        Text(
                                          timestamp,
                                          style: typography.bodySmall.copyWith(
                                            color: isTyping
                                                ? colors.primary
                                                : colors.textTertiary,
                                            fontSize: 10,
                                            fontWeight: isTyping
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '@${widget.contact.username}',
                                    style: typography.bodySmall.copyWith(
                                      color: colors.textSecondary,
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          lastMsg,
                                          style: typography.bodyMedium.copyWith(
                                            color: isTyping
                                                ? colors.primary
                                                : colors.textTertiary,
                                            fontSize: 12,
                                            fontWeight: isTyping
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                            fontStyle: isTyping
                                                ? FontStyle.italic
                                                : FontStyle.normal,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (unreadCount > 0)
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            gradient:
                                                context.appGradients.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            '$unreadCount',
                                            style: typography.bodySmall
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
