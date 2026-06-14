import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/services/call_coordinator.dart';
import 'package:vanish_link/features/chat/domain/services/ringtone_service.dart';
import 'package:vanish_link/features/chat/domain/services/call_notification_service.dart';
import 'package:vanish_link/features/chat/domain/services/call_presentation_adapter.dart';
import 'package:vanish_link/features/chat/domain/services/webrtc_service.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_state.dart';

import 'package:flutter_callkit_incoming/entities/call_event.dart' as ck;

class MockCallRepository extends Fake implements CallRepository {
  @override
  Future<void> updateCallStatus(String callId, String status) async {}
  @override
  Future<void> clearReadyStatuses(String callId) async {}
  @override
  Stream<Map<String, dynamic>> watchReadyStatus(String callId) => Stream.value({});
  @override
  Future<CallModel?> getCall(String callId) async => null;
  @override
  Future<void> showCallEndedNotification({required String callId}) async {}
}

class MockPresenceRepository extends Fake implements PresenceRepository {
  bool isBusyValue = false;
  String? lastUserId;

  @override
  Future<void> setUserBusy(String userId, bool busy) async {
    isBusyValue = busy;
    lastUserId = userId;
  }
}

class MockRingtoneService extends Fake implements RingtoneService {
  @override
  Future<void> play(dynamic type) async {}
  @override
  Future<void> stop() async {}
}

class MockCallNotificationService extends Fake implements CallNotificationService {
  @override
  Future<void> showCallEndedNotification({required String callId, required String callerName, required String type}) async {}
  @override
  Future<void> showMissedCallNotification({required String callId, required String callerName, required String type}) async {}
}

class MockCallPresentationAdapter extends Fake implements CallPresentationAdapter {
  @override
  Stream<ck.CallEvent?>? get onEvent => const Stream.empty();
  @override
  Future<void> endCall(String callId) async {}
}

class MockWebRtcService extends Fake implements WebRtcService {
  @override
  Stream<String> get connectionStateStream => const Stream.empty();
  @override
  Future<void> closeConnection(String sessionId) async {}
  @override
  Future<void> connect(String sessionId, String currentUserId, String peerUserId, [CallType type = CallType.audio, bool? isCaller]) async {}
}

class MockCallBloc extends Fake implements CallBloc {
  final _controller = StreamController<CallState>.broadcast();
  @override
  Stream<CallState> get stream => _controller.stream;
  @override
  CallState get state => const CallState.initial();

  void emit(CallState state) {
    _controller.add(state);
  }

  void dispose() {
    _controller.close();
  }
}

class FakeUser extends Fake implements User {
  @override
  final String uid;

  FakeUser(this.uid);
}

class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  final User? _currentUser;

  FakeFirebaseAuth({User? currentUser}) : _currentUser = currentUser;

  @override
  User? get currentUser => _currentUser;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CallCoordinator User Busy Audit', () {
    late MockCallRepository mockCallRepository;
    late MockPresenceRepository mockPresenceRepository;
    late MockRingtoneService mockRingtoneService;
    late MockCallNotificationService mockCallNotificationService;
    late MockCallPresentationAdapter mockCallPresentationAdapter;
    late MockWebRtcService mockWebRtcService;
    late MockCallBloc mockCallBloc;
    late FakeFirebaseAuth fakeAuth;
    late CallCoordinator coordinator;

    setUp(() {
      final getIt = GetIt.instance;
      mockCallRepository = MockCallRepository();
      mockPresenceRepository = MockPresenceRepository();
      mockRingtoneService = MockRingtoneService();
      mockCallNotificationService = MockCallNotificationService();
      mockCallPresentationAdapter = MockCallPresentationAdapter();
      mockWebRtcService = MockWebRtcService();
      mockCallBloc = MockCallBloc();
      fakeAuth = FakeFirebaseAuth(currentUser: FakeUser('caller_user_id'));

      getIt.registerSingleton<CallBloc>(mockCallBloc);
      getIt.registerLazySingleton<FirebaseAuth>(() => fakeAuth);

      coordinator = CallCoordinator(
        callRepository: mockCallRepository,
        presenceRepository: mockPresenceRepository,
        ringtoneService: mockRingtoneService,
        notificationService: mockCallNotificationService,
        callKitAdapter: mockCallPresentationAdapter,
        webRtcService: mockWebRtcService,
        firebaseAuth: fakeAuth,
      );
      coordinator.initialize();
    });

    tearDown(() {
      mockCallBloc.dispose();
      GetIt.instance.reset();
    });

    test('Simulate complete call lifecycle, printing [BUSY-AUDIT] and trace steps', () async {
      final callModel = CallModel(
        callId: 'test_call_id',
        callerId: 'caller_user_id',
        receiverId: 'receiver_user_id',
        type: CallType.audio,
        status: 'created',
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      // 1. CALL CREATED
      mockCallBloc.emit(CallState.calling(callModel));
      await Future.delayed(Duration.zero);

      // 2. CALL CONNECTING
      mockCallBloc.emit(CallState.connecting(callModel.copyWith(status: 'connecting')));
      await Future.delayed(Duration.zero);

      // 3. CALL ACCEPTED
      mockCallBloc.emit(CallState.connected(callModel.copyWith(status: 'accepted')));
      await Future.delayed(Duration.zero);

      // 4. CALL ACTIVE
      mockCallBloc.emit(CallState.active(callModel.copyWith(status: 'active')));
      await Future.delayed(Duration.zero);

      // 5. CALL ENDED
      mockCallBloc.emit(CallState.ended(callModel.copyWith(status: 'ended')));
      await Future.delayed(Duration.zero);
    });
  });
}
