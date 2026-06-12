import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';

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
        _updateStatus(PresenceStatusType.online);
        _connectionSubscription?.cancel();
        _connectionSubscription = _presenceRepository
            .watchConnectionState()
            .listen((connected) {
          if (connected && _currentUserId != null) {
            _updateStatus(PresenceStatusType.online);
          }
        });
      } else {
        if (_currentUserId != null) {
          _connectionSubscription?.cancel();
          _connectionSubscription = null;
          _updateStatus(PresenceStatusType.offline);
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
      _updateStatus(PresenceStatusType.offline);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_currentUserId == null) return;

    if (state == AppLifecycleState.resumed) {
      _presenceRepository.goOnline();
      _updateStatus(PresenceStatusType.online);
    } else if (state == AppLifecycleState.paused) {
      _updateStatus(PresenceStatusType.background);
    } else if (state == AppLifecycleState.detached) {
      _updateStatus(PresenceStatusType.offline);
    }
  }

  void _updateStatus(PresenceStatusType status) async {
    final uid = _currentUserId;
    if (uid == null) return;
    if (status == PresenceStatusType.online) {
      await _presenceRepository.setupOnDisconnect(uid);
      await _presenceRepository.setUserStatus(uid, PresenceStatusType.online);
    } else if (status == PresenceStatusType.background) {
      await _presenceRepository.setUserStatus(uid, PresenceStatusType.background);
    } else {
      await _presenceRepository.setUserStatus(uid, PresenceStatusType.offline);
      await _presenceRepository.goOffline();
    }
  }
}
