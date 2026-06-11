import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/routes/app_routes.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/widgets/app_empty_state.dart';
import 'package:vanish_link/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:vanish_link/features/chat/presentation/widgets/presence_indicator.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/core/utils/app_button.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatsBloc>(
      create: (_) => getIt<ChatsBloc>()..add(const ChatsEvent.started()),
      child: const _ChatScreenContent(),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  const _ChatScreenContent();

  @override
  State<_ChatScreenContent> createState() => _ChatScreenContentState();
}

class _ChatScreenContentState extends State<_ChatScreenContent> {
  final TextEditingController _searchController = TextEditingController();

  final List<UserProfile> _dummyContacts = List.generate(
    3,
    (index) => UserProfile(
      userId: 'dummy_$index',
      vanishId: 'VANISH_XXXX',
      username: 'username_placeholder',
      displayName: 'Display Name Placeholder',
      photoUrl: '',
      status: 'Available',
    ),
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chats',
                    style: typography.titleLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colors.textPrimary,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your conversations',
                    style: typography.bodyMedium.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: colors.border.withValues(alpha: context.isDark ? 0.3 : 0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.black.withValues(alpha: context.isDark ? 0.15 : 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    context.read<ChatsBloc>().add(ChatsEvent.searchQueryChanged(val));
                  },
                  style: typography.bodyMedium.copyWith(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Search conversations...',
                    hintStyle: typography.bodyMedium.copyWith(
                      color: colors.textTertiary,
                    ),
                    prefixIcon: Icon(CupertinoIcons.search, color: colors.textTertiary, size: 20),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear_rounded, color: colors.textTertiary, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              context.read<ChatsBloc>().add(const ChatsEvent.searchQueryChanged(''));
                              FocusScope.of(context).unfocus();
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Contacts List / State Switcher
            Expanded(
              child: BlocBuilder<ChatsBloc, ChatsState>(
                builder: (context, state) {
                  return state.map(
                    initial: (_) => const SizedBox.shrink(),
                    loading: (_) => Skeletonizer(
                      enabled: true,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        itemCount: _dummyContacts.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return _ContactCard(
                            contact: _dummyContacts[index],
                            onTap: () {},
                          );
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
                          title: 'No Results Found',
                          subtitle: 'Try searching for another name or username',
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 100),
                        itemCount: s.filteredContacts.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final contact = s.filteredContacts[index];

                          // Staggered entry animation for items
                          return TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 300 + (index * 50)),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: Opacity(
                                  opacity: value,
                                  child: child,
                                ),
                              );
                            },
                            child: _ContactCard(
                              contact: contact,
                              onTap: () {
                                HapticFeedback.lightImpact();
                                context.push(
                                  '${AppRoutes.chats}/${contact.userId}',
                                  extra: contact,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    error: (s) => Center(
                      child: Text(
                        s.message,
                        style: typography.bodyMedium.copyWith(color: colors.error),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final UserProfile contact;
  final VoidCallback onTap;

  const _ContactCard({
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    // Simulate an online/offline state placeholder
    final isOnline = contact.userId.hashCode % 2 == 0;

    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.border.withValues(alpha: context.isDark ? 0.3 : 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: context.isDark ? 0.2 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Avatar with presence overlay
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.primary.withValues(alpha: 0.15),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: contact.photoUrl.isNotEmpty
                              ? NetworkImage(contact.photoUrl)
                              : null,
                          backgroundColor: colors.primary.withValues(alpha: 0.08),
                          child: contact.photoUrl.isEmpty
                              ? Icon(
                                  Icons.person_rounded,
                                  color: colors.primary,
                                  size: 28,
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: PresenceIndicator(
                          isOnline: isOnline,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Name and Username details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.displayName,
                          style: typography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '@${contact.username}',
                          style: typography.bodyMedium.copyWith(
                            color: colors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          contact.status,
                          style: typography.bodySmall.copyWith(
                            color: colors.textTertiary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    color: colors.textTertiary,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}