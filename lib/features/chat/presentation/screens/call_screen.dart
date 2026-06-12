import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vanish_link/core/di/injection.dart';
import 'package:vanish_link/core/theme/app_theme.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_event.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_state.dart';
import 'package:vanish_link/features/chat/presentation/widgets/incoming_call_view.dart';
import 'package:vanish_link/features/chat/presentation/widgets/outgoing_call_view.dart';
import 'package:vanish_link/features/chat/presentation/widgets/call_widgets.dart';

class CallScreen extends StatefulWidget {
  final String callId;

  const CallScreen({
    super.key,
    required this.callId,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  UserProfile? _otherUser;
  String? _loadedUserId;
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  Timer? _uiTimer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    // Dispatch ListenToCall event to CallBloc
    getIt<CallBloc>().add(CallEvent.listenToCall(widget.callId));
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    super.dispose();
  }

  void _startLocalTimer() {
    _uiTimer?.cancel();
    _uiTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  void _stopLocalTimer() {
    _uiTimer?.cancel();
    _uiTimer = null;
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  Future<void> _loadOtherUserProfile(String userId) async {
    if (userId == _loadedUserId) return;
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
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

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return BlocListener<CallBloc, CallState>(
      listener: (context, state) {
        state.maybeMap(
          calling: (s) {
            final otherId = s.callModel.callerId == currentUserId ? s.callModel.receiverId : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          incomingCall: (s) {
            final otherId = s.callModel.callerId == currentUserId ? s.callModel.receiverId : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          connecting: (s) {
            final otherId = s.callModel.callerId == currentUserId ? s.callModel.receiverId : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
          },
          connected: (s) {
            final otherId = s.callModel.callerId == currentUserId ? s.callModel.receiverId : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
            _startLocalTimer();
          },
          active: (s) {
            final otherId = s.callModel.callerId == currentUserId ? s.callModel.receiverId : s.callModel.callerId;
            _loadOtherUserProfile(otherId);
            _startLocalTimer();
          },
          declined: (_) => _handleTermination('Call Declined'),
          missed: (_) => _handleTermination('Call Missed'),
          ended: (_) => _handleTermination('Call Ended'),
          failed: (s) => _handleTermination(s.message),
          error: (s) => _handleTermination(s.message),
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: context.appColors.background,
        body: Container(
          decoration: BoxDecoration(
            color: context.appColors.background,
          ),
          child: SafeArea(
            child: BlocBuilder<CallBloc, CallState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  error: (s) => Center(
                    child: Text(
                      s.message,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                    ),
                  ),
                  calling: (s) {
                    return OutgoingCallView(
                      contact: _otherUser,
                      status: s.callModel.status,
                      onCancel: () {
                        context.read<CallBloc>().add(const CallEvent.cancelCall());
                      },
                    );
                  },
                  incomingCall: (s) {
                    return IncomingCallView(
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
                    return OutgoingCallView(
                      contact: _otherUser,
                      status: 'connecting',
                      onCancel: () {
                        context.read<CallBloc>().add(const CallEvent.cancelCall());
                      },
                    );
                  },
                  connected: (s) {
                    return _buildConnectedView();
                  },
                  active: (s) {
                    return _buildConnectedView();
                  },
                  declined: (_) => _buildTerminationView('Call Declined'),
                  missed: (_) => _buildTerminationView('Call Missed'),
                  ended: (_) => _buildTerminationView('Call Ended'),
                  failed: (s) => _buildTerminationView(s.message),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectedView() {
    final colors = context.appColors;
    final typography = context.appTypography;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 56,
            backgroundImage: _otherUser?.photoUrl.isNotEmpty == true
                ? NetworkImage(_otherUser!.photoUrl)
                : null,
            backgroundColor: colors.primary.withValues(alpha: 0.08),
            child: _otherUser?.photoUrl.isNotEmpty != true
                ? Icon(
                    Icons.person_rounded,
                    color: colors.primary,
                    size: 56,
                  )
                : null,
          ),
          const SizedBox(height: 24),
          Text(
            _otherUser?.displayName ?? _otherUser?.username ?? 'VanishLink User',
            style: typography.titleLarge.copyWith(
              color: colors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formatDuration(_elapsedSeconds),
            style: typography.headlineLarge.copyWith(
              color: colors.textPrimary,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Mute Button
              IconButton(
                iconSize: 32,
                color: _isMuted ? colors.primary : colors.textSecondary,
                icon: Icon(_isMuted ? Icons.mic_off_rounded : Icons.mic_rounded),
                onPressed: () {
                  setState(() {
                    _isMuted = !_isMuted;
                  });
                },
              ),
              // End Call Button
              CallActionButton(
                icon: Icons.call_end_rounded,
                backgroundColor: colors.error,
                iconColor: colors.white,
                onTap: () {
                  _stopLocalTimer();
                  context.read<CallBloc>().add(const CallEvent.endCall());
                },
                label: 'End Call',
                size: 72,
              ),
              // Speaker Button
              IconButton(
                iconSize: 32,
                color: _isSpeakerOn ? colors.primary : colors.textSecondary,
                icon: Icon(_isSpeakerOn ? Icons.volume_up_rounded : Icons.volume_down_rounded),
                onPressed: () {
                  setState(() {
                    _isSpeakerOn = !_isSpeakerOn;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTerminationView(String message) {
    final colors = context.appColors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CircularProgressIndicator(color: colors.primary),
        ],
      ),
    );
  }

  void _handleTermination(String message) {
    _stopLocalTimer();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        context.pop();
      }
    });
  }
}
