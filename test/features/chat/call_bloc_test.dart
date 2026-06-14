import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:vanish_link/core/services/permission_manager.dart';
import 'package:vanish_link/features/chat/domain/entities/call_model.dart';
import 'package:vanish_link/features/chat/domain/repositories/call_repository.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_bloc.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_event.dart';
import 'package:vanish_link/features/chat/presentation/bloc/call/call_state.dart';
import 'package:vanish_link/features/chat/domain/services/call_delivery_contracts.dart';

class FakePermissionManager extends Fake implements PermissionManager {
  @override
  Future<VanishPermissionStatus> checkPermissionStatus(VanishPermissionType type) async {
    return VanishPermissionStatus.granted;
  }

  @override
  Future<VanishPermissionStatus> requestPermission(VanishPermissionType type) async {
    return VanishPermissionStatus.granted;
  }
}

class FakeCallRepository implements CallRepository {
  final StreamController<CallModel?> _callController = StreamController<CallModel?>.broadcast();
  final List<CallModel> storedHistory = [];
  final List<String> statusUpdates = [];
  String? acceptedCallId;
  String? declinedCallId;
  String? cancelledCallId;
  String? endedCallId;
  int? endedDuration;

  void emitCall(CallModel? call) {
    _callController.add(call);
  }

  @override
  Future<CallModel> createCall({
    required String callerId,
    required String receiverId,
    required CallType type,
  }) async {
    return CallModel(
      callId: 'call_123',
      callerId: callerId,
      receiverId: receiverId,
      type: type,
      status: 'calling',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<void> acceptCall(String callId) async {
    acceptedCallId = callId;
  }

  @override
  Future<void> declineCall(String callId) async {
    declinedCallId = callId;
  }

  @override
  Future<void> cancelCall(String callId) async {
    cancelledCallId = callId;
  }

  @override
  Future<void> endCall(String callId, int duration) async {
    endedCallId = callId;
    endedDuration = duration;
  }

  @override
  Future<void> updateCallStatus(String callId, String status) async {
    statusUpdates.add('$callId:$status');
  }

  @override
  Stream<CallModel?> watchCall(String callId) {
    return _callController.stream;
  }

  @override
  Stream<CallModel?> watchIncomingCalls(String userId) {
    return Stream.value(null);
  }

  @override
  Future<void> storeCallHistory(CallModel call) async {
    storedHistory.add(call);
  }

  @override
  Future<void> setReadyStatus(String callId, String userId) async {}

  @override
  Stream<Map<String, dynamic>> watchReadyStatus(String callId) {
    return Stream.value({});
  }

  @override
  Future<void> clearReadyStatuses(String callId) async {}

  @override
  Future<CallModel?> getCall(String callId) async {
    return null;
  }

  void dispose() {
    _callController.close();
  }
}

class FakeCallDeliveryNotificationTrigger implements CallDeliveryNotificationTrigger {
  @override
  Future<void> triggerIncomingCallPush(CallModel call) async {}
  @override
  Future<void> triggerMissedCallPush(CallModel call) async {}
  @override
  Future<void> triggerTimeoutCallPush(CallModel call) async {}
  @override
  Future<void> triggerDeclinedCallPush(CallModel call) async {}
  @override
  Future<void> triggerEndedCallPush(CallModel call) async {}
}

void main() {
  group('CallBloc Tests', () {
    late FakeCallRepository fakeRepository;
    late CallBloc callBloc;

    setUp(() {
      final getIt = GetIt.instance;
      if (!getIt.isRegistered<PermissionManager>()) {
        getIt.registerSingleton<PermissionManager>(FakePermissionManager());
      }
      if (!getIt.isRegistered<CallDeliveryNotificationTrigger>()) {
        getIt.registerSingleton<CallDeliveryNotificationTrigger>(FakeCallDeliveryNotificationTrigger());
      }
      fakeRepository = FakeCallRepository();
      callBloc = CallBloc(callRepository: fakeRepository);
    });

    tearDown(() {
      callBloc.close();
      fakeRepository.dispose();
      GetIt.instance.reset();
    });

    test('Initial state is CallState.initial()', () {
      expect(callBloc.state, const CallState.initial());
    });

    test('CreateCall dispatches successfully, updates status and starts listening', () async {
      callBloc.add(const CallEvent.createCall(
        callerId: 'user_A',
        receiverId: 'user_B',
        type: CallType.audio,
      ));
      await Future.delayed(Duration.zero);

      // Verify state is calling
      expect(
        callBloc.state.maybeMap(
          calling: (s) => s.callModel.callerId == 'user_A' && s.callModel.receiverId == 'user_B',
          orElse: () => false,
        ),
        isTrue,
      );
    });

    test('CallUpdated event transition calling -> ringing -> connected -> ended', () async {
      final now = DateTime.now().millisecondsSinceEpoch;
      final call = CallModel(
        callId: 'call_123',
        callerId: 'user_A',
        receiverId: 'user_B',
        type: CallType.audio,
        status: 'calling',
        createdAt: now,
      );

      callBloc.add(CallEvent.listenToCall(call.callId));
      await Future.delayed(Duration.zero);

      // Emit calling
      fakeRepository.emitCall(call);
      await Future.delayed(Duration.zero);
      expect(callBloc.state, CallState.calling(call));

      // Emit ringing
      final ringingCall = call.copyWith(status: 'ringing');
      fakeRepository.emitCall(ringingCall);
      await Future.delayed(Duration.zero);
      expect(callBloc.state, CallState.incomingCall(ringingCall));

      // Emit accepted
      final acceptedCall = ringingCall.copyWith(status: 'accepted');
      fakeRepository.emitCall(acceptedCall);
      await Future.delayed(Duration.zero);
      expect(callBloc.state, CallState.connected(acceptedCall));

      // Emit ended
      final endedCall = acceptedCall.copyWith(status: 'ended');
      fakeRepository.emitCall(endedCall);
      await Future.delayed(Duration.zero);
      expect(callBloc.state, CallState.ended(endedCall));
      expect(fakeRepository.storedHistory, contains(endedCall));
    });

    test('AcceptCall, DeclineCall, CancelCall, EndCall call repository methods', () async {
      final now = DateTime.now().millisecondsSinceEpoch;
      final call = CallModel(
        callId: 'call_123',
        callerId: 'user_A',
        receiverId: 'user_B',
        type: CallType.audio,
        status: 'calling',
        createdAt: now,
      );

      callBloc.add(CallEvent.listenToCall(call.callId));
      await Future.delayed(Duration.zero);
      fakeRepository.emitCall(call);
      await Future.delayed(Duration.zero);

      // Cancel Call
      callBloc.add(const CallEvent.cancelCall());
      await Future.delayed(Duration.zero);
      expect(fakeRepository.cancelledCallId, 'call_123');

      // Ringing state for Decline/Accept
      final ringing = call.copyWith(status: 'ringing');
      fakeRepository.emitCall(ringing);
      await Future.delayed(Duration.zero);

      callBloc.add(const CallEvent.declineCall());
      await Future.delayed(Duration.zero);
      expect(fakeRepository.declinedCallId, 'call_123');

      callBloc.add(const CallEvent.acceptCall());
      await Future.delayed(Duration.zero);
      expect(fakeRepository.acceptedCallId, 'call_123');
    });

    test('CreateCall is blocked if there is already an active call', () async {
      // 1. Establish an active call
      callBloc.add(const CallEvent.createCall(
        callerId: 'user_A',
        receiverId: 'user_B',
        type: CallType.audio,
      ));
      await Future.delayed(Duration.zero);

      expect(
        callBloc.state.maybeMap(
          calling: (_) => true,
          orElse: () => false,
        ),
        isTrue,
      );

      // 2. Try to dispatch another CreateCall event
      callBloc.add(const CallEvent.createCall(
        callerId: 'user_A',
        receiverId: 'user_C',
        type: CallType.audio,
      ));
      await Future.delayed(Duration.zero);

      // 3. State should have turned into error state with the active call message
      expect(
        callBloc.state.maybeMap(
          error: (e) => e.message == 'You already have an active call.',
          orElse: () => false,
        ),
        isTrue,
      );
    });
  });
}
