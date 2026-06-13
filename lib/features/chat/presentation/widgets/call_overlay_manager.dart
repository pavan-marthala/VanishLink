import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_event.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_state.dart';
import 'package:vanish_link/features/chat/presentation/widgets/call_widgets.dart';
import 'package:vanish_link/core/utils/sized_context.dart';
import 'package:vanish_link/features/chat/domain/services/call_coordinator.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vanish_link/features/chat/domain/services/webrtc_service.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';

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
  bool _isCameraOn = true;
  bool _isMinimized = false;
  double _minimizedX = -1.0;
  double _minimizedY = -1.0;
  Timer? _durationTimer;
  int _elapsedSeconds = 0;
  String? _lastTerminatedMessage;
  StreamSubscription<User?>? _authSubscription;
  CallType _activeCallType = CallType.audio;

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
          _isMuted = false;
          _isSpeakerOn = false;
          _isCameraOn = true;
          _elapsedSeconds = 0;
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
        debugPrint('[CALL-LIFECYCLE] CallOverlayManager: listener received state: $state');
        state.maybeMap(
          initial: (_) {
            if (_otherUser != null || _loadedUserId != null || _elapsedSeconds != 0) {
              debugPrint('[CALL-LIFECYCLE] Self-healing trigger in CallOverlayManager: CallBloc is initial but overlay state had stale variables. Resetting variables silently.');
              _stopDurationTimer();
              setState(() {
                _otherUser = null;
                _loadedUserId = null;
                _isMinimized = false;
                _minimizedX = -1.0;
                _minimizedY = -1.0;
                _isMuted = false;
                _isSpeakerOn = false;
                _isCameraOn = true;
                _elapsedSeconds = 0;
                _lastTerminatedMessage = null;
              });
            }
          },
          calling: (s) {
            debugPrint('[CALL-UI] Showing call screen for calling status');
            setState(() {
              _isMuted = false;
              _isSpeakerOn = false;
              _isCameraOn = true;
              _elapsedSeconds = 0;
              _activeCallType = s.callModel.type;
            });
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          incomingCall: (s) {
            debugPrint('[CALL-UI] Showing call screen for incomingCall status');
            setState(() {
              _isMuted = false;
              _isSpeakerOn = false;
              _isCameraOn = true;
              _elapsedSeconds = 0;
              _activeCallType = s.callModel.type;
            });
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          connecting: (s) {
            debugPrint('[CALL-UI] Keeping call screen during connecting status');
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          connected: (s) {
            debugPrint('[CALL-UI] Keeping call screen during connected status');
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          active: (s) {
            debugPrint('[CALL-UI] Keeping call screen during active status');
            final otherId = s.callModel.callerId == currentUserId
                ? s.callModel.receiverId
                : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
            _startDurationTimer();
          },
          declined: (_) {
            debugPrint('[CALL-UI] Closing call screen: declined');
            _handleTermination('Call Declined');
          },
          missed: (_) {
            debugPrint('[CALL-UI] Closing call screen: missed');
            _handleTermination('Call Missed');
          },
          ended: (_) {
            debugPrint('[CALL-UI] Closing call screen: ended');
            _handleTermination('Call Ended');
          },
          failed: (s) {
            debugPrint('[CALL-UI] Closing call screen: failed. Message: ${s.message}');
            _handleTermination(s.message);
          },
          error: (s) {
            debugPrint('[CALL-UI] Closing call screen: error. Message: ${s.message}');
            _handleTermination(s.message);
          },
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
              initial: (_) {
                debugPrint('[CALL-UI] Building initial: returning SizedBox.shrink');
                return const SizedBox.shrink();
              },
              error: (s) {
                debugPrint('[CALL-UI] Building error (message=${s.message}): returning SizedBox.shrink');
                return const SizedBox.shrink();
              },
              calling: (s) {
                final isCaller = s.callModel.callerId == currentUserId;
                if (!isCaller) {
                  debugPrint('[CALL-UI] Building calling (isCaller=false): skipping presentation (returning SizedBox.shrink)');
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
                  callType: s.callModel.type,
                  onAccept: () {
                    context.read<CallBloc>().add(const CallEvent.acceptCall());
                  },
                  onDecline: () {
                    context.read<CallBloc>().add(const CallEvent.declineCall());
                  },
                );
              },
              connecting: (s) {
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
                if (_activeCallType == CallType.video) {
                  return _buildVideoCallOverlay(context);
                }
                return _buildFullscreenBackdrop(
                  child: ActiveCallOverlay(
                    contact: _otherUser,
                    durationText: _formatDuration(_elapsedSeconds),
                    isMuted: _isMuted,
                    isSpeakerOn: _isSpeakerOn,
                    onMuteToggle: () {
                      setState(() => _isMuted = !_isMuted);
                      getIt<CallCoordinator>().setMicrophoneMuted(_isMuted);
                    },
                    onSpeakerToggle: () {
                      setState(() => _isSpeakerOn = !_isSpeakerOn);
                      getIt<CallCoordinator>().setSpeakerphoneOn(_isSpeakerOn);
                    },
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
                if (_activeCallType == CallType.video) {
                  return _buildVideoCallOverlay(context);
                }
                return _buildFullscreenBackdrop(
                  child: ActiveCallOverlay(
                    contact: _otherUser,
                    durationText: _formatDuration(_elapsedSeconds),
                    isMuted: _isMuted,
                    isSpeakerOn: _isSpeakerOn,
                    onMuteToggle: () {
                      setState(() => _isMuted = !_isMuted);
                      getIt<CallCoordinator>().setMicrophoneMuted(_isMuted);
                    },
                    onSpeakerToggle: () {
                      setState(() => _isSpeakerOn = !_isSpeakerOn);
                      getIt<CallCoordinator>().setSpeakerphoneOn(_isSpeakerOn);
                    },
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

  /// Builds the full-screen video call overlay using [ActiveVideoCallOverlay].
  /// Accesses [WebRtcService] renderers directly from the service locator.
  Widget _buildVideoCallOverlay(BuildContext context) {
    final webRtcService = getIt<WebRtcService>();
    return ActiveVideoCallOverlay(
      contact: _otherUser,
      durationText: _formatDuration(_elapsedSeconds),
      isMuted: _isMuted,
      isCameraOn: _isCameraOn,
      localRenderer: webRtcService.localRenderer,
      remoteRenderer: webRtcService.remoteRenderer,
      onMuteToggle: () {
        setState(() => _isMuted = !_isMuted);
        getIt<CallCoordinator>().setMicrophoneMuted(_isMuted);
      },
      onCameraToggle: () {
        setState(() => _isCameraOn = !_isCameraOn);
        getIt<CallCoordinator>().toggleCamera(_isCameraOn);
      },
      onSwitchCamera: () {
        getIt<CallCoordinator>().switchCamera();
      },
      onMinimize: () => setState(() => _isMinimized = true),
      onEnd: () {
        _stopDurationTimer();
        context.read<CallBloc>().add(const CallEvent.endCall());
      },
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
            callType: _activeCallType,
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
  final CallType callType;

  const IncomingCallOverlay({
    super.key,
    required this.contact,
    required this.onAccept,
    required this.onDecline,
    this.callType = CallType.audio,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDesktop = context.isDesktop;
    final topPadding = MediaQuery.paddingOf(context).top;
    final double topSpacing = topPadding > 0 ? topPadding + 10.0 : 20.0;
    final double screenWidth = context.widthPx;
    final bool isVideoCall = callType == CallType.video;

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
                        Row(
                          children: [
                            Icon(
                              isVideoCall
                                  ? Icons.videocam_rounded
                                  : Icons.phone_rounded,
                              size: 14,
                              color: colors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isVideoCall
                                  ? 'Incoming Video Call...'
                                  : 'Incoming Voice Call...',
                              style: context.appTypography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
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
                      icon: Icon(
                        isVideoCall
                            ? Icons.videocam_rounded
                            : Icons.phone_rounded,
                        size: 18,
                      ),
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
                  if (!kIsWeb)
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

/// ────────────────────────────────────────────────────────────────────────────
/// Active Video Call Overlay
/// Full-screen video layout: remote video background, local PiP, controls.
/// ────────────────────────────────────────────────────────────────────────────
class ActiveVideoCallOverlay extends StatelessWidget {
  final UserProfile? contact;
  final String durationText;
  final bool isMuted;
  final bool isCameraOn;
  final RTCVideoRenderer? localRenderer;
  final RTCVideoRenderer? remoteRenderer;
  final VoidCallback onMuteToggle;
  final VoidCallback onCameraToggle;
  final VoidCallback onSwitchCamera;
  final VoidCallback onMinimize;
  final VoidCallback onEnd;

  const ActiveVideoCallOverlay({
    super.key,
    required this.contact,
    required this.durationText,
    required this.isMuted,
    required this.isCameraOn,
    required this.localRenderer,
    required this.remoteRenderer,
    required this.onMuteToggle,
    required this.onCameraToggle,
    required this.onSwitchCamera,
    required this.onMinimize,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Remote video (full background) ──────────────────────────────
          Container(color: Colors.black),
          if (remoteRenderer != null)
            RTCVideoView(
              remoteRenderer!,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              mirror: false,
            )
          else
            // Fallback when remote video not yet connected
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: contact?.photoUrl.isNotEmpty == true
                        ? NetworkImage(contact!.photoUrl)
                        : null,
                    backgroundColor: Colors.white10,
                    child: contact?.photoUrl.isNotEmpty != true
                        ? const Icon(
                            Icons.person_rounded,
                            color: Colors.white54,
                            size: 64,
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    contact?.displayName ?? contact?.username ?? 'VanishLink User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          // ── Top bar: duration + minimize ────────────────────────────────
          Positioned(
            top: topPadding + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    durationText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close_fullscreen_rounded,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black38,
                  ),
                  onPressed: onMinimize,
                ),
              ],
            ),
          ),

          // ── Local camera PiP (top-right corner) ─────────────────────────
          Positioned(
            top: topPadding + 64,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 96,
                height: 128,
                child: isCameraOn && localRenderer != null
                    ? RTCVideoView(
                        localRenderer!,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        mirror: true,
                      )
                    : Container(
                        color: Colors.black54,
                        child: const Center(
                          child: Icon(
                            Icons.videocam_off_rounded,
                            color: Colors.white54,
                            size: 32,
                          ),
                        ),
                      ),
              ),
            ),
          ),

          // ── Bottom control bar ──────────────────────────────────────────
          Positioned(
            bottom: bottomPadding + 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Mute
                _VideoControlButton(
                  icon: isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                  label: isMuted ? 'Unmute' : 'Mute',
                  active: isMuted,
                  onTap: onMuteToggle,
                ),
                // End call
                _VideoControlButton(
                  icon: Icons.call_end_rounded,
                  label: 'End',
                  isEndCall: true,
                  onTap: onEnd,
                ),
                // Camera toggle
                _VideoControlButton(
                  icon: isCameraOn
                      ? Icons.videocam_rounded
                      : Icons.videocam_off_rounded,
                  label: isCameraOn ? 'Camera On' : 'Camera Off',
                  active: !isCameraOn,
                  onTap: onCameraToggle,
                ),
                // Switch camera (native only)
                if (!kIsWeb)
                  _VideoControlButton(
                    icon: Icons.flip_camera_ios_rounded,
                    label: 'Flip',
                    onTap: onSwitchCamera,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small circular button used in [ActiveVideoCallOverlay]'s control bar.
class _VideoControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;
  final bool isEndCall;

  const _VideoControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    this.isEndCall = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isEndCall
        ? Colors.red
        : active
            ? Colors.white
            : Colors.black45;
    final Color iconColor = isEndCall
        ? Colors.white
        : active
            ? Colors.black87
            : Colors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            shadows: [
              Shadow(color: Colors.black54, blurRadius: 4),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class DraggableCallOverlay extends StatelessWidget {
  final UserProfile? contact;
  final String status;
  final CallType callType;
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
    this.callType = CallType.audio,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.appTypography;
    final bool isVideo = callType == CallType.video;

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
                      '${isVideo ? 'Video' : 'Voice'} Call • ${status == 'connected' ? durationText : 'Calling...'}',
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
