import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';

class PresenceService with WidgetsBindingObserver {
  final PresenceRepository _presenceRepository;
  final FirebaseAuth _auth;
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<bool>? _connectionSubscription;
  String? _currentUserId;

  PresenceService({
    required PresenceRepository presenceRepository,
    FirebaseAuth? auth,
  })  : _presenceRepository = presenceRepository,
        _auth = auth ?? FirebaseAuth.instance;

  /// Starts listening to authentication and app lifecycle changes
  void startMonitoring() {
    WidgetsBinding.instance.addObserver(this);
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        _currentUserId = user.uid;
        _presenceRepository.goOnline();
        _goOnline();
        _connectionSubscription?.cancel();
        _connectionSubscription = _presenceRepository
            .watchConnectionState()
            .listen((connected) {
          if (connected && _currentUserId != null) {
            _goOnline();
          }
        });
      } else {
        if (_currentUserId != null) {
          _connectionSubscription?.cancel();
          _connectionSubscription = null;
          _goOffline();
          _currentUserId = null;
        }
      }
    });
  }

  /// Stops monitoring and cleans up listeners
  void stopMonitoring() {
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription?.cancel();
    _connectionSubscription?.cancel();
    _connectionSubscription = null;
    if (_currentUserId != null) {
      _goOffline();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_currentUserId == null) return;

    if (state == AppLifecycleState.resumed) {
      _presenceRepository.goOnline();
      _goOnline();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _goOffline();
    }
  }

  void _goOnline() {
    final uid = _currentUserId;
    if (uid == null) return;
    _presenceRepository.setupOnDisconnect(uid);
    _presenceRepository.setUserOnline(uid, true);
  }

  void _goOffline() async {
    final uid = _currentUserId;
    if (uid == null) return;
    await _presenceRepository.setUserOnline(uid, false);
    await _presenceRepository.goOffline();
  }
}
