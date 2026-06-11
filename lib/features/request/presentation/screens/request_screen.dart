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
import 'package:vanish_link/features/request/presentation/bloc/requests_bloc.dart';
import 'package:vanish_link/features/request/domain/entities/friend_request.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  // Dummy data list used for skeleton loaders matching the exact card design
  final List<FriendRequest> _dummyRequests = List.generate(
    3,
    (index) => FriendRequest(
      requestId: 'dummy_$index',
      fromUserId: 'sender_$index',
      toUserId: 'receiver_$index',
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      senderProfile: UserProfile(
        userId: 'sender_$index',
        vanishId: 'VANISH_XXXX',
        username: 'username_placeholder',
        displayName: 'Display Name Placeholder',
        photoUrl: '',
        status: 'Available',
      ),
      receiverProfile: UserProfile(
        userId: 'receiver_$index',
        vanishId: 'VANISH_XXXX',
        username: 'username_placeholder',
        displayName: 'Display Name Placeholder',
        photoUrl: '',
        status: 'Available',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final gradients = context.appGradients;
    final isDesktop = checkDesktopSize(context);

    return BlocProvider<RequestsBloc>(
      create: (context) => getIt<RequestsBloc>()..add(const RequestsEvent.started()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: context.isDark ? gradients.backgroundDark : gradients.backgroundLight,
          ),
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 600 : double.infinity),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.largePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimens.extraLargePadding),
                      // Header Section
                      Text(
                        'Requests',
                        style: typography.displaySmall.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colors.textPrimary,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage your connections',
                        style: typography.bodyLarge.copyWith(
                          color: colors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimens.veryLargePadding),

                      // Segmented Sliding Tab Control
                      BlocBuilder<RequestsBloc, RequestsState>(
                        builder: (context, state) {
                          final isIncoming = state.maybeMap(
                            loaded: (s) => s.isIncomingTab,
                            orElse: () => true,
                          );
                          return _SegmentedControl(
                            isIncoming: isIncoming,
                            onTabChanged: (val) {
                              context.read<RequestsBloc>().add(RequestsEvent.toggleTab(isIncoming: val));
                            },
                          );
                        },
                      ),
                      const SizedBox(height: Dimens.veryLargePadding),

                      // Stream-driven List Content
                      Expanded(
                        child: BlocConsumer<RequestsBloc, RequestsState>(
                          listener: (context, state) {
                            state.mapOrNull(
                              loaded: (loadedState) {
                                if (loadedState.actionError != null) {
                                  showErrorToast(message: loadedState.actionError!);
                                }
                              },
                            );
                          },
                          builder: (context, state) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: state.map(
                                initial: (_) => const SizedBox.shrink(),
                                loading: (_) => Skeletonizer(
                                  key: const ValueKey('loading_state'),
                                  enabled: true,
                                  child: ListView.separated(
                                    itemCount: _dummyRequests.length,
                                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                                    itemBuilder: (context, index) => _RequestCard(
                                      request: _dummyRequests[index],
                                      isIncoming: true,
                                      isProcessing: false,
                                      onAccept: () {},
                                      onDecline: () {},
                                      onCancel: () {},
                                    ),
                                  ),
                                ),
                                loaded: (s) {
                                  final requests = s.isIncomingTab ? s.incomingRequests : s.outgoingRequests;

                                  if (requests.isEmpty) {
                                    return s.isIncomingTab
                                        ? const _EmptyState(
                                            key: ValueKey('empty_incoming'),
                                            icon: Icons.notifications_none_rounded,
                                            title: 'No Incoming Requests',
                                            subtitle: 'When someone sends you a request, it will appear here.',
                                          )
                                        : const _EmptyState(
                                            key: ValueKey('empty_outgoing'),
                                            icon: Icons.send_rounded,
                                            title: 'No Pending Requests',
                                            subtitle: 'Search for users and start connecting.',
                                          );
                                  }

                                  return ListView.separated(
                                    key: ValueKey(s.isIncomingTab ? 'list_incoming' : 'list_outgoing'),
                                    itemCount: requests.length,
                                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                                    itemBuilder: (context, index) {
                                      final req = requests[index];
                                      final isProcessing = s.processingRequestIds.contains(req.requestId);

                                      // Staggered list entry animation
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
                                        child: _RequestCard(
                                          request: req,
                                          isIncoming: s.isIncomingTab,
                                          isProcessing: isProcessing,
                                          onAccept: () {
                                            context.read<RequestsBloc>().add(
                                                  RequestsEvent.acceptRequest(
                                                    requestId: req.requestId,
                                                    fromUserId: req.fromUserId,
                                                    toUserId: req.toUserId,
                                                  ),
                                                );
                                          },
                                          onDecline: () {
                                            context.read<RequestsBloc>().add(
                                                  RequestsEvent.declineRequest(requestId: req.requestId),
                                                );
                                          },
                                          onCancel: () {
                                            context.read<RequestsBloc>().add(
                                                  RequestsEvent.cancelRequest(requestId: req.requestId),
                                                );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                error: (s) => _EmptyState(
                                  key: const ValueKey('error_state'),
                                  icon: Icons.error_outline_rounded,
                                  title: 'Error Loading Requests',
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

class _SegmentedControl extends StatelessWidget {
  final bool isIncoming;
  final ValueChanged<bool> onTabChanged;

  const _SegmentedControl({
    required this.isIncoming,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.border.withValues(alpha: context.isDark ? 0.3 : 0.5),
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          // Sliding background highlight
          AnimatedAlign(
            alignment: isIncoming ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: context.appGradients.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Tab Options text
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onTabChanged(true);
                  },
                  child: Center(
                    child: Text(
                      'Incoming',
                      style: typography.bodyMedium.copyWith(
                        color: isIncoming ? Colors.white : colors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onTabChanged(false);
                  },
                  child: Center(
                    child: Text(
                      'Outgoing',
                      style: typography.bodyMedium.copyWith(
                        color: !isIncoming ? Colors.white : colors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final FriendRequest request;
  final bool isIncoming;
  final bool isProcessing;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onCancel;

  const _RequestCard({
    required this.request,
    required this.isIncoming,
    required this.isProcessing,
    required this.onAccept,
    required this.onDecline,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    final user = isIncoming ? request.senderProfile : request.receiverProfile;
    if (user == null) return const SizedBox.shrink();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.primary.withValues(alpha: 0.15),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: user.photoUrl.isNotEmpty ? NetworkImage(user.photoUrl) : null,
                  backgroundColor: colors.primary.withValues(alpha: 0.08),
                  child: user.photoUrl.isEmpty
                      ? Icon(
                          Icons.person_rounded,
                          color: colors.primary,
                          size: 24,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              // Name Block
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
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (!isIncoming)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.warning.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colors.warning.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    'Pending',
                    style: typography.bodySmall.copyWith(
                      color: colors.warning,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // User Status Row
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _getStatusColor(colors, user.status),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  user.status,
                  style: typography.bodySmall.copyWith(
                    color: colors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action Buttons
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isProcessing
                ? SizedBox(
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
                : _buildActions(context, colors, typography),
          ),
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

  Widget _buildActions(BuildContext context, AppColors colors, AppTypography typography) {
    if (isIncoming) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // Success double haptic
                HapticFeedback.lightImpact();
                Future.delayed(const Duration(milliseconds: 50), () {
                  HapticFeedback.lightImpact();
                });
                onAccept();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                    'Accept',
                    style: typography.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                onDecline();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: colors.border.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Decline',
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onCancel();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: colors.error.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.error.withValues(alpha: 0.2),
            ),
          ),
          child: Center(
            child: Text(
              'Cancel Request',
              style: typography.bodyMedium.copyWith(
                color: colors.error,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
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
                  child: Icon(
                    icon,
                    size: 48,
                    color: Colors.white,
                  ),
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
