import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/repositories/message_repository.dart';

class UnreadService with WidgetsBindingObserver {
  final MessageRepository _messageRepository;
  final FirebaseAuth _auth;
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<Map<String, int>>? _unreadSubscription;

  static bool isAppInForeground = true;
  static String? activeChatId;

  final StreamController<int> _globalUnreadCountController = StreamController<int>.broadcast();
  final StreamController<Map<String, int>> _unreadCountsPerChatController = StreamController<Map<String, int>>.broadcast();

  int _currentGlobalCount = 0;
  Map<String, int> _currentCountsPerChat = const {};

  UnreadService({
    required MessageRepository messageRepository,
    FirebaseAuth? auth,
  })  : _messageRepository = messageRepository,
        _auth = auth ?? FirebaseAuth.instance;

  Stream<int> get globalUnreadCount => _globalUnreadCountController.stream;
  Stream<Map<String, int>> get unreadCountsPerChat => _unreadCountsPerChatController.stream;

  int get currentGlobalCount => _currentGlobalCount;
  Map<String, int> get currentCountsPerChat => _currentCountsPerChat;

  void startMonitoring() {
    WidgetsBinding.instance.addObserver(this);
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        _startWatchingUnreads(user.uid);
      } else {
        _stopWatchingUnreads();
      }
    });
  }

  void stopMonitoring() {
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription?.cancel();
    _stopWatchingUnreads();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      isAppInForeground = true;
      final uid = _auth.currentUser?.uid;
      final chatId = activeChatId;
      if (uid != null && chatId != null) {
        _messageRepository.markChatAsRead(chatId: chatId, userId: uid);
        _messageRepository.markMessagesAsRead(chatId: chatId, currentUserId: uid);
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      isAppInForeground = false;
    }
  }

  void _startWatchingUnreads(String userId) {
    _unreadSubscription?.cancel();
    _unreadSubscription = _messageRepository.watchAllUnreadCounts(userId).listen(
      (counts) {
        _currentCountsPerChat = counts;
        _unreadCountsPerChatController.add(counts);

        // Sum up all unread counts
        final total = counts.values.fold<int>(0, (sum, val) => sum + val);
        _currentGlobalCount = total;
        _globalUnreadCountController.add(total);
      },
      onError: (e) {
        // Handle gracefully
      },
    );
  }

  void _stopWatchingUnreads() {
    _unreadSubscription?.cancel();
    _unreadSubscription = null;
    _currentGlobalCount = 0;
    _currentCountsPerChat = const {};
    _globalUnreadCountController.add(0);
    _unreadCountsPerChatController.add(const {});
  }

  void dispose() {
    stopMonitoring();
    _globalUnreadCountController.close();
    _unreadCountsPerChatController.close();
  }
}
