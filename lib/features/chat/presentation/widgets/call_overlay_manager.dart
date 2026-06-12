import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_event.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_state.dart';
import 'package:vanish_link/features/chat/presentation/widgets/call_widgets.dart';
import 'package:vanish_link/core/utils/sized_context.dart';

class CallOverlayManager extends StatefulWidget {
  final Widget? child;
  const CallOverlayManager({super.key, this.child});

  @override
  State<CallOverlayManager> createState() => _CallOverlayManagerState();
}

class _CallOverlayManagerState extends State<CallOverlayManager> {
  UserProfile? _otherUser;
  String? _loadedUserId;
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isMinimized = false;
  double _minimizedX = -1.0;
  double _minimizedY = -1.0;
  Timer? _durationTimer;
  int _elapsedSeconds = 0;
  String? _lastTerminatedMessage;
  StreamSubscription<User?>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _startDurationTimer() {
    _durationTimer?.cancel();
    _elapsedSeconds = 0;
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  Future<void> _loadOtherUserProfile(String userId) async {
    if (userId == _loadedUserId) return;
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists && mounted) {
        final data = doc.data();
        if (data != null) {
          setState(() {
            _otherUser = UserProfile(
              userId: data['userId'] as String? ?? '',
              vanishId: data['vanishId'] as String? ?? '',
              username: data['username'] as String? ?? '',
              displayName: data['displayName'] as String? ?? '',
              photoUrl: data['photoUrl'] as String? ?? '',
              status: data['status'] as String? ?? '',
            );
            _loadedUserId = userId;
          });
        }
      }
    } catch (_) {}
  }

  void _handleTermination(String message) {
    _stopDurationTimer();
    setState(() {
      _lastTerminatedMessage = message;
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _lastTerminatedMessage = null;
          _otherUser = null;
          _loadedUserId = null;
          _isMinimized = false;
          _minimizedX = -1.0;
          _minimizedY = -1.0;
        });
        getIt<CallBloc>().add(const CallEvent.callUpdated(null));
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _durationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return widget.child ?? const SizedBox.shrink();

    return BlocListener<CallBloc, CallState>(
      listener: (context, state) {
        state.maybeMap(
          calling: (s) {
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          incomingCall: (s) {
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          connecting: (s) {
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          connected: (s) {
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
            _startDurationTimer();
          },
          active: (s) {
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
            _startDurationTimer();
          },
          declined: (_) => _handleTermination('Call Declined'),
          missed: (_) => _handleTermination('Call Missed'),
          ended: (_) => _handleTermination('Call Ended'),
          failed: (s) => _handleTermination(s.message),
          error: (s) => _handleTermination(s.message),
          orElse: () {},
        );
      },
      child: BlocBuilder<CallBloc, CallState>(
        builder: (context, state) {
          final colors = context.appColors;

          Widget overlayWidget = const SizedBox.shrink();

          if (_lastTerminatedMessage != null) {
            overlayWidget = _buildFullscreenBackdrop(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: colors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colors.border.withValues(alpha: 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.black.withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _lastTerminatedMessage!,
                        style: context.appTypography.titleLarge.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CircularProgressIndicator(color: colors.primary),
                    ],
                  ),
                ),
              ),
            );
          } else {
            overlayWidget = state.map(
              initial: (_) => const SizedBox.shrink(),
              error: (_) => const SizedBox.shrink(),
              calling: (s) {
                final isCaller = s.callModel.callerId == currentUserId;
                if (!isCaller) {
                  return const SizedBox.shrink();
                }
                if (_isMinimized) {
                  return _buildMinimizedWidget(s.callModel.status);
                }
                return _buildFullscreenBackdrop(
                  child: OutgoingCallOverlay(
                    contact: _otherUser,
                    status: s.callModel.status,
                    onMinimize: () => setState(() => _isMinimized = true),
                    onCancel: () {
                      context.read<CallBloc>().add(
                        const CallEvent.cancelCall(),
                      );
                    },
                  ),
                );
              },
              incomingCall: (s) {
                final isReceiver = s.callModel.receiverId == currentUserId;
                if (!isReceiver) {
                  if (_isMinimized) {
                    return _buildMinimizedWidget(s.callModel.status);
                  }
                  return _buildFullscreenBackdrop(
                    child: OutgoingCallOverlay(
                      contact: _otherUser,
                      status: s.callModel.status,
                      onMinimize: () => setState(() => _isMinimized = true),
                      onCancel: () {
                        context.read<CallBloc>().add(
                          const CallEvent.cancelCall(),
                        );
                      },
                    ),
                  );
                }
                return IncomingCallOverlay(
                  contact: _otherUser,
                  onAccept: () {
                    context.read<CallBloc>().add(const CallEvent.acceptCall());
                  },
                  onDecline: () {
                    context.read<CallBloc>().add(const CallEvent.declineCall());
                  },
                );
              },
              connecting: (s) {
                final isCaller = s.callModel.callerId == currentUserId;
                if (!isCaller) return const SizedBox.shrink();
                if (_isMinimized) {
                  return _buildMinimizedWidget('connecting');
                }
                return _buildFullscreenBackdrop(
                  child: OutgoingCallOverlay(
                    contact: _otherUser,
                    status: 'connecting',
                    onMinimize: () => setState(() => _isMinimized = true),
                    onCancel: () {
                      context.read<CallBloc>().add(
                        const CallEvent.cancelCall(),
                      );
                    },
                  ),
                );
              },
              connected: (s) {
                if (_isMinimized) {
                  return _buildMinimizedWidget('connected');
                }
                return _buildFullscreenBackdrop(
                  child: ActiveCallOverlay(
                    contact: _otherUser,
                    durationText: _formatDuration(_elapsedSeconds),
                    isMuted: _isMuted,
                    isSpeakerOn: _isSpeakerOn,
                    onMuteToggle: () => setState(() => _isMuted = !_isMuted),
                    onSpeakerToggle: () =>
                        setState(() => _isSpeakerOn = !_isSpeakerOn),
                    onMinimize: () => setState(() => _isMinimized = true),
                    onEnd: () {
                      _stopDurationTimer();
                      context.read<CallBloc>().add(const CallEvent.endCall());
                    },
                  ),
                );
              },
              active: (s) {
                if (_isMinimized) {
                  return _buildMinimizedWidget('connected');
                }
                return _buildFullscreenBackdrop(
                  child: ActiveCallOverlay(
                    contact: _otherUser,
                    durationText: _formatDuration(_elapsedSeconds),
                    isMuted: _isMuted,
                    isSpeakerOn: _isSpeakerOn,
                    onMuteToggle: () => setState(() => _isMuted = !_isMuted),
                    onSpeakerToggle: () =>
                        setState(() => _isSpeakerOn = !_isSpeakerOn),
                    onMinimize: () => setState(() => _isMinimized = true),
                    onEnd: () {
                      _stopDurationTimer();
                      context.read<CallBloc>().add(const CallEvent.endCall());
                    },
                  ),
                );
              },
              declined: (_) => const SizedBox.shrink(),
              missed: (_) => const SizedBox.shrink(),
              ended: (_) => const SizedBox.shrink(),
              failed: (_) => const SizedBox.shrink(),
            );
          }

          return Stack(
            children: [widget.child ?? const SizedBox.shrink(), overlayWidget],
          );
        },
      ),
    );
  }

  Widget _buildFullscreenBackdrop({required Widget child}) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: context.appColors.background.withValues(alpha: 0.95),
        width: double.infinity,
        height: double.infinity,
        child: child,
      ),
    );
  }

  Widget _buildMinimizedWidget(String status) {
    final double screenWidth = context.widthPx;
    final double screenHeight = context.heightPx;
    final double topPadding = MediaQuery.paddingOf(context).top;
    final double cardWidth = 260.0;
    final double cardHeight = 72.0;

    // Calculate default position
    if (_minimizedX < 0 || _minimizedY < 0) {
      _minimizedX = screenWidth - cardWidth - 16.0;
      _minimizedY = topPadding > 0 ? topPadding + 16.0 : 80.0;
    }

    return Positioned(
      left: _minimizedX,
      top: _minimizedY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _minimizedX += details.delta.dx;
            _minimizedY += details.delta.dy;

            // Keep card within visible screen bounds
            _minimizedX = _minimizedX.clamp(
              16.0,
              screenWidth - cardWidth - 16.0,
            );
            _minimizedY = _minimizedY.clamp(
              topPadding + 16.0,
              screenHeight - cardHeight - 16.0,
            );
          });
        },
        child: SizedBox(
          width: cardWidth,
          child: DraggableCallOverlay(
            contact: _otherUser,
            status: status,
            durationText: _formatDuration(_elapsedSeconds),
            onTap: () => setState(() => _isMinimized = false),
            onEnd: () {
              _stopDurationTimer();
              context.read<CallBloc>().add(const CallEvent.endCall());
            },
          ),
        ),
      ),
    );
  }
}

class IncomingCallOverlay extends StatelessWidget {
  final UserProfile? contact;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const IncomingCallOverlay({
    super.key,
    required this.contact,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDesktop = context.isDesktop;
    final topPadding = MediaQuery.paddingOf(context).top;
    final double topSpacing = topPadding > 0 ? topPadding + 10.0 : 20.0;
    final double screenWidth = context.widthPx;

    // Desktop: Compact FaceTime-style floating card in the top-right
    // Mobile: Fully responsive width respecting borders
    final double cardWidth = !context.isMobile ? 340.0 : screenWidth - 32;

    return Positioned(
      top: isDesktop ? 20.0 : topSpacing,
      right: isDesktop ? 20.0 : null,
      left: isDesktop ? null : 16.0,
      width: cardWidth,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.border.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: 0.15),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Caller Info Block
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: contact?.photoUrl.isNotEmpty == true
                        ? NetworkImage(contact!.photoUrl)
                        : null,
                    backgroundColor: colors.primary.withValues(alpha: 0.08),
                    child: contact?.photoUrl.isEmpty == true
                        ? Icon(Icons.person, color: colors.primary, size: 24)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          contact?.displayName ??
                              contact?.username ??
                              'VanishLink User',
                          style: context.appTypography.titleMedium.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Incoming Voice Call...',
                          style: context.appTypography.bodyMedium.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Dedicated Accept and Decline Buttons (Horizontal single row with equal sizing)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onDecline,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.error,
                        side: BorderSide(
                          color: colors.error.withValues(alpha: 0.5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.phone_disabled_rounded, size: 18),
                      label: Text(
                        'Decline',
                        style: context.appTypography.bodyMedium.copyWith(
                          color: colors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onAccept,
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.success,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.phone_rounded, size: 18),
                      label: Text(
                        'Accept',
                        style: context.appTypography.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

class OutgoingCallOverlay extends StatelessWidget {
  final UserProfile? contact;
  final String status;
  final VoidCallback onMinimize;
  final VoidCallback onCancel;

  const OutgoingCallOverlay({
    super.key,
    required this.contact,
    required this.status,
    required this.onMinimize,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Stack(
      children: [
        Positioned(
          top: MediaQuery.paddingOf(context).top + 10.0,
          right: 20,
          child: IconButton(
            icon: Icon(
              Icons.close_fullscreen_rounded,
              color: colors.textPrimary,
            ),
            onPressed: onMinimize,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: contact?.photoUrl.isNotEmpty == true
                    ? NetworkImage(contact!.photoUrl)
                    : null,
                backgroundColor: colors.primary.withValues(alpha: 0.08),
                child: contact?.photoUrl.isNotEmpty != true
                    ? Icon(
                        Icons.person_rounded,
                        color: colors.primary,
                        size: 64,
                      )
                    : null,
              ),
              const SizedBox(height: 24),
              Text(
                contact?.displayName ?? contact?.username ?? 'VanishLink User',
                style: typography.titleLarge.copyWith(
                  color: colors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CallStatusIndicator(status: status),
              const SizedBox(height: 64),
              CallActionButton(
                icon: Icons.call_end_rounded,
                backgroundColor: colors.error,
                iconColor: colors.white,
                onTap: onCancel,
                label: 'Cancel',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActiveCallOverlay extends StatelessWidget {
  final UserProfile? contact;
  final String durationText;
  final bool isMuted;
  final bool isSpeakerOn;
  final VoidCallback onMuteToggle;
  final VoidCallback onSpeakerToggle;
  final VoidCallback onMinimize;
  final VoidCallback onEnd;

  const ActiveCallOverlay({
    super.key,
    required this.contact,
    required this.durationText,
    required this.isMuted,
    required this.isSpeakerOn,
    required this.onMuteToggle,
    required this.onSpeakerToggle,
    required this.onMinimize,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Stack(
      children: [
        Positioned(
          top: MediaQuery.paddingOf(context).top + 10.0,
          right: 20,
          child: IconButton(
            icon: Icon(
              Icons.close_fullscreen_rounded,
              color: colors.textPrimary,
            ),
            onPressed: onMinimize,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundImage: contact?.photoUrl.isNotEmpty == true
                    ? NetworkImage(contact!.photoUrl)
                    : null,
                backgroundColor: colors.primary.withValues(alpha: 0.08),
                child: contact?.photoUrl.isNotEmpty != true
                    ? Icon(
                        Icons.person_rounded,
                        color: colors.primary,
                        size: 56,
                      )
                    : null,
              ),
              const SizedBox(height: 24),
              Text(
                contact?.displayName ?? contact?.username ?? 'VanishLink User',
                style: typography.titleLarge.copyWith(
                  color: colors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                durationText,
                style: typography.headlineLarge.copyWith(
                  color: colors.textPrimary,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 32,
                    color: isMuted ? colors.primary : colors.textSecondary,
                    icon: Icon(
                      isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                    ),
                    onPressed: onMuteToggle,
                  ),
                  CallActionButton(
                    icon: Icons.call_end_rounded,
                    backgroundColor: colors.error,
                    iconColor: Colors.white,
                    onTap: onEnd,
                    label: 'End Call',
                    size: 72,
                  ),
                  IconButton(
                    iconSize: 32,
                    color: isSpeakerOn ? colors.primary : colors.textSecondary,
                    icon: Icon(
                      isSpeakerOn
                          ? Icons.volume_up_rounded
                          : Icons.volume_down_rounded,
                    ),
                    onPressed: onSpeakerToggle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DraggableCallOverlay extends StatelessWidget {
  final UserProfile? contact;
  final String status;
  final String durationText;
  final VoidCallback onTap;
  final VoidCallback onEnd;

  const DraggableCallOverlay({
    super.key,
    required this.contact,
    required this.status,
    required this.durationText,
    required this.onTap,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: contact?.photoUrl.isNotEmpty == true
                    ? NetworkImage(contact!.photoUrl)
                    : null,
                backgroundColor: colors.primary.withValues(alpha: 0.08),
                child: contact?.photoUrl.isEmpty == true
                    ? Icon(Icons.person, color: colors.primary, size: 18)
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      contact?.displayName ?? contact?.username ?? 'Call',
                      style: typography.bodyMedium.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Voice Call • ${status == 'connected' ? durationText : 'Calling...'}',
                      style: typography.bodySmall.copyWith(
                        color: colors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap:
                    () {}, // Swallows taps to prevent outer card restore trigger
                child: IconButton(
                  icon: const Icon(
                    Icons.call_end_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: colors.error,
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: onEnd,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
