import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/theme/app_colors.dart';
import 'package:vanish_link/core/theme/app_typography.dart';
import 'package:vanish_link/core/utils/dimens.dart';
import 'package:vanish_link/core/utils/check_device_size.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/discover/domain/repositories/discover_repository.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy data list used for skeleton loaders matching the exact card design
  final List<UserProfile> _dummyUsers = List.generate(
    4,
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
    final gradients = context.appGradients;
    final isDesktop = checkDesktopSize(context);

    return BlocProvider<DiscoverBloc>(
      create: (context) => getIt<DiscoverBloc>(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: context.isDark
                ? gradients.backgroundDark
                : gradients.backgroundLight,
          ),
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 600 : double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.largePadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimens.padding),
                      // Header Title Section
                      Text(
                        'Discover',
                        style: typography.displaySmall.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colors.textPrimary,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Find and connect with people',
                        style: typography.bodyLarge.copyWith(
                          color: colors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimens.veryLargePadding),

                      // Capsule Styled Search Input
                      BlocBuilder<DiscoverBloc, DiscoverState>(
                        builder: (context, state) {
                          return _SearchField(
                            controller: _searchController,
                            onChanged: (val) {
                              context.read<DiscoverBloc>().add(
                                DiscoverEvent.searchQueryChanged(val),
                              );
                            },
                            onClear: () {
                              context.read<DiscoverBloc>().add(
                                const DiscoverEvent.searchQueryChanged(''),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: Dimens.veryLargePadding),

                      // Results & Animated States Section
                      Expanded(
                        child: BlocConsumer<DiscoverBloc, DiscoverState>(
                          listener: (context, state) {
                            state.mapOrNull(
                              results: (resultsState) {
                                // Trigger notification toasts for inline failures
                                resultsState.actionErrors.forEach((
                                  userId,
                                  error,
                                ) {
                                  if (error != null) {
                                    showErrorToast(message: error);
                                  }
                                });
                              },
                            );
                          },
                          builder: (context, state) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: state.map(
                                initial: (_) => const _EmptyState(
                                  key: ValueKey('initial_state'),
                                  icon: Icons.explore_outlined,
                                  title: 'Find People',
                                  subtitle:
                                      'Search by username or Vanish ID suffix',
                                ),
                                searching: (_) => Skeletonizer(
                                  key: const ValueKey('searching_state'),
                                  enabled: true,
                                  child: ListView.separated(
                                    itemCount: _dummyUsers.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) => _UserCard(
                                      user: _dummyUsers[index],
                                      friendshipStatus: FriendshipStatus.none,
                                      isSending: false,
                                      onSendRequest: () {},
                                    ),
                                  ),
                                ),
                                results: (s) => ListView.separated(
                                  key: const ValueKey('results_state'),
                                  itemCount: s.users.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final user = s.users[index];
                                    final status =
                                        s.friendshipStatuses[user.userId] ??
                                        FriendshipStatus.none;
                                    final isSending = s.sendingRequestUserIds
                                        .contains(user.userId);

                                    // Staggered entry animation for items
                                    return TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                        begin: 0.0,
                                        end: 1.0,
                                      ),
                                      duration: Duration(
                                        milliseconds: 300 + (index * 50),
                                      ),
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
                                      child: _UserCard(
                                        user: user,
                                        friendshipStatus: status,
                                        isSending: isSending,
                                        onSendRequest: () {
                                          context.read<DiscoverBloc>().add(
                                            DiscoverEvent.sendFriendRequest(
                                              targetUserId: user.userId,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                empty: (_) => const _SearchEmptyState(
                                  key: ValueKey('empty_state'),
                                ),
                                error: (s) => _EmptyState(
                                  key: const ValueKey('error_state'),
                                  icon: Icons.error_outline_rounded,
                                  title: 'Error Occurred',
                                  subtitle: s.message,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final TextEditingController controller;

  const _SearchField({
    required this.onChanged,
    required this.onClear,
    required this.controller,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: context.isDark
            ? colors.white.withValues(alpha: _isFocused ? 0.06 : 0.03)
            : colors.black.withValues(alpha: _isFocused ? 0.05 : 0.03),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _isFocused
              ? colors.primary
              : colors.border.withValues(alpha: 0.5),
          width: _isFocused ? 1.5 : 1.0,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: _isFocused ? colors.primary : colors.textTertiary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              style: typography.bodyMedium.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.text,
              onTapOutside: (event) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: InputDecoration(
                hintText: 'Search username or Vanish ID',
                hintStyle: TextStyle(
                  color: colors.textTertiary.withValues(alpha: 0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                widget.controller.clear();
                widget.onClear();
              },
              child: Icon(
                Icons.close_rounded,
                color: colors.textTertiary,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserProfile user;
  final FriendshipStatus friendshipStatus;
  final bool isSending;
  final VoidCallback onSendRequest;

  const _UserCard({
    required this.user,
    required this.friendshipStatus,
    required this.isSending,
    required this.onSendRequest,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

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
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Profile Avatar with Online Status Dot
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
                  backgroundImage: user.photoUrl.isNotEmpty
                      ? NetworkImage(user.photoUrl)
                      : null,
                  backgroundColor: colors.primary.withValues(alpha: 0.08),
                  child: user.photoUrl.isEmpty
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
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: _getStatusColor(colors, user.status),
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.card, width: 2.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // User Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: typography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '@${user.username}',
                  style: typography.bodyMedium.copyWith(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      user.status,
                      style: typography.bodySmall.copyWith(
                        color: colors.textTertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (user.vanishId.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: colors.textTertiary.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          user.vanishId,
                          style: typography.bodySmall.copyWith(
                            color: colors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Inline Friend Request Button
          _buildActionButton(context),
        ],
      ),
    );
  }

  Color _getStatusColor(AppColors colors, String status) {
    switch (status.toLowerCase()) {
      case 'available':
      case 'online':
        return colors.success;
      case 'busy':
      case 'dnd':
      case 'do not disturb':
        return colors.error;
      case 'away':
      case 'idle':
        return colors.warning;
      default:
        return colors.inActiveStatus;
    }
  }

  Widget _buildActionButton(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isSending
          ? SizedBox(
              width: 100,
              height: 36,
              child: Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.primary,
                  ),
                ),
              ),
            )
          : _getButtonForStatus(context, colors, typography),
    );
  }

  Widget _getButtonForStatus(
    BuildContext context,
    AppColors colors,
    AppTypography typography,
  ) {
    switch (friendshipStatus) {
      case FriendshipStatus.none:
        return InkWell(
          onTap: () {
            // Premium haptic interaction
            HapticFeedback.lightImpact();
            onSendRequest();
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              gradient: context.appGradients.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Add Friend',
                style: typography.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      case FriendshipStatus.pendingSent:
        return Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_rounded, color: colors.primary, size: 14),
                const SizedBox(width: 4),
                Text(
                  'Sent',
                  style: typography.bodyMedium.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      case FriendshipStatus.pendingReceived:
        return Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colors.warning.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.warning.withValues(alpha: 0.2)),
          ),
          child: Center(
            child: Text(
              'Pending',
              style: typography.bodyMedium.copyWith(
                color: colors.warning,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        );
      case FriendshipStatus.contacts:
        return Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colors.success.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.success.withValues(alpha: 0.2)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_rounded, color: colors.success, size: 14),
                const SizedBox(width: 4),
                Text(
                  'Friends',
                  style: typography.bodyMedium.copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Glowing Icon Wrapper with Radial Gradient background
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
                padding: const EdgeInsets.all(18),
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
                  child: Icon(icon, size: 48, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: typography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: typography.bodyMedium.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  const _SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

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
                    colors.error.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  radius: 0.8,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.card,
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.3),
                  ),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [colors.error, colors.errorLight],
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.search_off_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Users Found',
              style: typography.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Try another username or Vanish ID',
              style: typography.bodyMedium.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
