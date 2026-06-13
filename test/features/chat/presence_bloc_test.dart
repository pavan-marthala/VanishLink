import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/services/presence_service.dart';
import 'package:vanish_link/features/chat/presentation/bloc/presence/presence_bloc.dart';
import 'package:vanish_link/core/utils/device_identifier_provider.dart';

class FakePresenceRepository implements PresenceRepository {
  final StreamController<PresenceStatus> _presenceController = StreamController<PresenceStatus>.broadcast();
  String? watchedUserId;
  final List<String> onlineUserUpdates = [];
  final List<String> disconnectSetups = [];

  void emitPresence(PresenceStatus status) {
    _presenceController.add(status);
  }

  void emitError(Object error) {
    _presenceController.addError(error);
  }

  @override
  Stream<PresenceStatus> watchPresence(String userId) {
    watchedUserId = userId;
    return _presenceController.stream;
  }

  @override
  Future<void> setUserOnline(String userId, bool online) async {
    if (online) {
      onlineUserUpdates.add(userId);
    } else {
      onlineUserUpdates.add('$userId:offline');
    }
  }

  @override
  Future<void> setupOnDisconnect(String userId) async {
    disconnectSetups.add(userId);
  }

  @override
  Future<void> setUserStatus(String userId, PresenceStatusType status) async {
    if (status != PresenceStatusType.offline) {
      onlineUserUpdates.add(userId);
    } else {
      onlineUserUpdates.add('$userId:offline');
    }
  }

  @override
  Future<void> goOnline() async {}

  @override
  Future<void> goOffline() async {}

  @override
  Stream<bool> watchConnectionState() => Stream.value(true);

  @override
  Future<void> updateDevicePushToken({
    required String userId,
    required String deviceId,
    required String token,
    required String platform,
    required bool notificationPermission,
    required bool microphonePermission,
    required bool cameraPermission,
  }) async {}

  @override
  Future<void> removeDevicePushToken(String userId, String deviceId) async {}

  void dispose() {
    _presenceController.close();
  }
}

class FakeUser extends Fake implements User {
  @override
  final String uid;

  FakeUser(this.uid);
}

class FakeDeviceIdentifierProvider implements DeviceIdentifierProvider {
  @override
  Future<String> getIdentifier() async => 'test_device_id';

  @override
  Future<String> getPlatform() async => 'android';
}

class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  final StreamController<User?> _authStateChangesController = StreamController<User?>.broadcast();

  @override
  Stream<User?> authStateChanges() => _authStateChangesController.stream;

  void emitUser(User? user) {
    _authStateChangesController.add(user);
  }

  void dispose() {
    _authStateChangesController.close();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PresenceBloc Tests', () {
    late FakePresenceRepository fakeRepository;
    late PresenceBloc presenceBloc;

    setUp(() {
      fakeRepository = FakePresenceRepository();
      presenceBloc = PresenceBloc(presenceRepository: fakeRepository);
    });

    tearDown(() {
      presenceBloc.close();
      fakeRepository.dispose();
    });

    test('Initial state is PresenceState.unknown()', () {
      expect(presenceBloc.state, const PresenceState.unknown());
    });

    test('MonitorUser with empty or dummy userId emits PresenceState.unknown()', () async {
      presenceBloc.add(const PresenceEvent.monitorUser(''));
      await Future.delayed(Duration.zero);
      expect(presenceBloc.state, const PresenceState.unknown());

      presenceBloc.add(const PresenceEvent.monitorUser('dummy_123'));
      await Future.delayed(Duration.zero);
      expect(presenceBloc.state, const PresenceState.unknown());
    });

    test('MonitorUser with valid userId starts listening and emits updates', () async {
      presenceBloc.add(const PresenceEvent.monitorUser('user_abc'));
      await Future.delayed(Duration.zero);
      expect(fakeRepository.watchedUserId, 'user_abc');

      // Emit online status
      final now = DateTime.now();
      fakeRepository.emitPresence(PresenceStatus(online: true, lastSeen: now));
      await Future.delayed(Duration.zero);
      expect(presenceBloc.state, const PresenceState.online());

      // Emit offline status
      fakeRepository.emitPresence(PresenceStatus(online: false, lastSeen: now));
      await Future.delayed(Duration.zero);
      expect(presenceBloc.state, PresenceState.offline(lastSeen: now));
    });

    test('MonitorUser emits PresenceState.unknown() on stream error', () async {
      presenceBloc.add(const PresenceEvent.monitorUser('user_abc'));
      await Future.delayed(Duration.zero);

      fakeRepository.emitError(Exception('Stream error'));
      await Future.delayed(Duration.zero);
      expect(presenceBloc.state, const PresenceState.unknown());
    });
  });

  group('PresenceService Tests', () {
    late FakePresenceRepository fakeRepository;
    late FakeFirebaseAuth fakeAuth;
    late PresenceService presenceService;

    setUp(() {
      fakeRepository = FakePresenceRepository();
      fakeAuth = FakeFirebaseAuth();
      presenceService = PresenceService(
        presenceRepository: fakeRepository,
        deviceIdentifierProvider: FakeDeviceIdentifierProvider(),
        auth: fakeAuth,
      );
    });

    tearDown(() {
      presenceService.stopMonitoring();
      fakeAuth.dispose();
      fakeRepository.dispose();
    });

    test('Auth sign-in triggers setUserOnline(true) and setupOnDisconnect', () async {
      presenceService.startMonitoring();
      await Future.delayed(Duration.zero);

      fakeAuth.emitUser(FakeUser('user_123'));
      await Future.delayed(Duration.zero);

      expect(fakeRepository.onlineUserUpdates, contains('user_123'));
      expect(fakeRepository.disconnectSetups, contains('user_123'));
    });

    test('Auth sign-out triggers setUserOnline(false)', () async {
      presenceService.startMonitoring();
      await Future.delayed(Duration.zero);

      // Sign in first
      fakeAuth.emitUser(FakeUser('user_123'));
      await Future.delayed(Duration.zero);

      // Sign out
      fakeAuth.emitUser(null);
      await Future.delayed(Duration.zero);

      expect(fakeRepository.onlineUserUpdates, contains('user_123:offline'));
    });

    test('AppLifecycleState changes trigger setUserOnline', () async {
      presenceService.startMonitoring();
      await Future.delayed(Duration.zero);

      // Set user online
      fakeAuth.emitUser(FakeUser('user_123'));
      await Future.delayed(Duration.zero);
      fakeRepository.onlineUserUpdates.clear();

      // Go background
      presenceService.didChangeAppLifecycleState(AppLifecycleState.paused);
      expect(fakeRepository.onlineUserUpdates, contains('user_123:offline'));
      fakeRepository.onlineUserUpdates.clear();

      // Go foreground
      presenceService.didChangeAppLifecycleState(AppLifecycleState.resumed);
      expect(fakeRepository.onlineUserUpdates, contains('user_123'));
    });
  });
}
