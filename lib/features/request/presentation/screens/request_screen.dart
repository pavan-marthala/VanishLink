import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/core/utils/dimens.dart';
import 'package:vanish_link/core/utils/check_device_size.dart';
import 'package:vanish_link/core/utils/app_toast.dart';
import 'package:vanish_link/core/widgets/app_empty_state.dart';
import 'package:vanish_link/core/widgets/app_request_card.dart';
import 'package:vanish_link/core/widgets/skeletons.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/features/request/presentation/bloc/requests_bloc.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

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
                                    itemCount: 3,
                                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                                    itemBuilder: (context, index) => const RequestCardSkeleton(),
                                  ),
                                ),
                                loaded: (s) {
                                  final requests = s.isIncomingTab ? s.incomingRequests : s.outgoingRequests;

                                  if (requests.isEmpty) {
                                    return s.isIncomingTab
                                        ? const AppEmptyState(
                                            key: ValueKey('empty_incoming'),
                                            icon: Icons.notifications_none_rounded,
                                            title: 'No Incoming Requests',
                                            subtitle: 'When someone sends you a request, it will appear here.',
                                          )
                                        : const AppEmptyState(
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
                                      final user = s.isIncomingTab ? req.senderProfile : req.receiverProfile;

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
                                        child: AppRequestCard(
                                          request: req,
                                          isIncoming: s.isIncomingTab,
                                          isProcessing: isProcessing,
                                          presenceWidget: user == null ? null : BlocProvider<PresenceBloc>(
                                            create: (context) => getIt<PresenceBloc>()..add(PresenceEvent.monitorUser(user.userId)),
                                            child: BlocBuilder<PresenceBloc, PresenceState>(
                                              builder: (context, presenceState) {
                                                final isOnline = presenceState.isOnline;
                                                final presenceText = presenceState.displayStatus;

                                                return Row(
                                                  children: [
                                                    Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        color: isOnline ? colors.success : colors.inActiveStatus,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        presenceText,
                                                        style: typography.bodySmall.copyWith(
                                                          color: colors.textTertiary,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
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
                                error: (s) => AppEmptyState(
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


