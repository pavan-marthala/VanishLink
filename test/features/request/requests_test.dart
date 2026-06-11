import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:vanish_link/features/request/domain/entities/friend_request.dart';
import 'package:vanish_link/features/request/domain/repositories/request_repository.dart';
import 'package:vanish_link/features/request/presentation/bloc/requests_bloc.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

class FakeRequestRepository implements RequestRepository {
  final StreamController<List<FriendRequest>> _incomingController = StreamController<List<FriendRequest>>.broadcast();
  final StreamController<List<FriendRequest>> _outgoingController = StreamController<List<FriendRequest>>.broadcast();

  bool acceptCalled = false;
  bool declineCalled = false;
  bool cancelCalled = false;
  String? acceptedRequestId;
  String? declinedRequestId;
  String? cancelledRequestId;

  bool shouldThrowError = false;

  void emitIncoming(List<FriendRequest> requests) {
    _incomingController.add(requests);
  }

  void emitOutgoing(List<FriendRequest> requests) {
    _outgoingController.add(requests);
  }

  @override
  Stream<List<FriendRequest>> watchIncomingRequests() => _incomingController.stream;

  @override
  Stream<List<FriendRequest>> watchOutgoingRequests() => _outgoingController.stream;

  @override
  Future<void> acceptRequest(String requestId, String fromUserId, String toUserId) async {
    if (shouldThrowError) throw Exception('Accept failed');
    acceptCalled = true;
    acceptedRequestId = requestId;
  }

  @override
  Future<void> declineRequest(String requestId) async {
    if (shouldThrowError) throw Exception('Decline failed');
    declineCalled = true;
    declinedRequestId = requestId;
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    if (shouldThrowError) throw Exception('Cancel failed');
    cancelCalled = true;
    cancelledRequestId = requestId;
  }

  void dispose() {
    _incomingController.close();
    _outgoingController.close();
  }
}

void main() {
  group('RequestsBloc Tests', () {
    late FakeRequestRepository fakeRepository;
    late RequestsBloc requestsBloc;

    final testSender = const UserProfile(
      userId: 'sender_1',
      vanishId: 'vanish_SENDER1',
      username: 'sender_user',
      displayName: 'Sender User',
      photoUrl: '',
      status: 'Available',
    );

    final testReceiver = const UserProfile(
      userId: 'receiver_1',
      vanishId: 'vanish_RECEIVER1',
      username: 'receiver_user',
      displayName: 'Receiver User',
      photoUrl: '',
      status: 'Available',
    );

    final incomingRequest = FriendRequest(
      requestId: 'req_incoming_1',
      fromUserId: 'sender_1',
      toUserId: 'current_user',
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      senderProfile: testSender,
    );

    final outgoingRequest = FriendRequest(
      requestId: 'req_outgoing_1',
      fromUserId: 'current_user',
      toUserId: 'receiver_1',
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      receiverProfile: testReceiver,
    );

    setUp(() {
      fakeRepository = FakeRequestRepository();
      requestsBloc = RequestsBloc(requestRepository: fakeRepository);
    });

    tearDown(() {
      requestsBloc.close();
      fakeRepository.dispose();
    });

    test('Initial state is RequestsState.initial()', () {
      expect(requestsBloc.state, const RequestsState.initial());
    });

    test('Started event emits loading state and subscribes to streams', () async {
      requestsBloc.add(const RequestsEvent.started());

      // Wait for BLoC to process 'Started' event and transition to loading
      await Future.delayed(const Duration(milliseconds: 10));
      expect(requestsBloc.state, const RequestsState.loading());

      // Pushing data to repository streams
      fakeRepository.emitIncoming([incomingRequest]);
      fakeRepository.emitOutgoing([outgoingRequest]);

      // Wait for stream updates to propagate and be processed by BLoC
      await Future.delayed(const Duration(milliseconds: 10));

      expect(
        requestsBloc.state,
        RequestsState.loaded(
          incomingRequests: [incomingRequest],
          outgoingRequests: [outgoingRequest],
          isIncomingTab: true,
          processingRequestIds: const {},
        ),
      );
    });

    test('ToggleTab switches isIncomingTab in loaded state', () async {
      // 1. Get into loaded state
      requestsBloc.add(const RequestsEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitIncoming([incomingRequest]);
      fakeRepository.emitOutgoing([outgoingRequest]);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Toggle tab
      requestsBloc.add(const RequestsEvent.toggleTab(isIncoming: false));
      await Future.delayed(const Duration(milliseconds: 10));
      
      expect(
        requestsBloc.state,
        RequestsState.loaded(
          incomingRequests: [incomingRequest],
          outgoingRequests: [outgoingRequest],
          isIncomingTab: false,
          processingRequestIds: const {},
        ),
      );
    });

    test('AcceptRequest successful state transitions', () async {
      // 1. Get into loaded state
      requestsBloc.add(const RequestsEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitIncoming([incomingRequest]);
      fakeRepository.emitOutgoing([outgoingRequest]);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Accept incoming request
      requestsBloc.add(const RequestsEvent.acceptRequest(
        requestId: 'req_incoming_1',
        fromUserId: 'sender_1',
        toUserId: 'current_user',
      ));

      // Should optimistically add to processingRequestIds
      await Future.microtask(() {});
      requestsBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.processingRequestIds.contains('req_incoming_1'), isTrue);
          expect(s.actionError, isNull);
        },
      );

      // Wait for repository call to complete
      await Future.delayed(const Duration(milliseconds: 10));

      expect(fakeRepository.acceptCalled, isTrue);
      expect(fakeRepository.acceptedRequestId, 'req_incoming_1');

      // Processing ID should be removed
      requestsBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.processingRequestIds.contains('req_incoming_1'), isFalse);
        },
      );
    });

    test('AcceptRequest failure sets actionError', () async {
      fakeRepository.shouldThrowError = true;

      // 1. Get into loaded state
      requestsBloc.add(const RequestsEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitIncoming([incomingRequest]);
      fakeRepository.emitOutgoing([outgoingRequest]);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Accept incoming request
      requestsBloc.add(const RequestsEvent.acceptRequest(
        requestId: 'req_incoming_1',
        fromUserId: 'sender_1',
        toUserId: 'current_user',
      ));

      // Wait for repository call to fail
      await Future.delayed(const Duration(milliseconds: 10));

      requestsBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.processingRequestIds.contains('req_incoming_1'), isFalse);
          expect(s.actionError, isNotNull);
        },
      );
    });

    test('DeclineRequest successful state transitions', () async {
      // 1. Get into loaded state
      requestsBloc.add(const RequestsEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitIncoming([incomingRequest]);
      fakeRepository.emitOutgoing([outgoingRequest]);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Decline incoming request
      requestsBloc.add(const RequestsEvent.declineRequest(
        requestId: 'req_incoming_1',
      ));

      // Should optimistically add to processingRequestIds
      await Future.microtask(() {});
      requestsBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.processingRequestIds.contains('req_incoming_1'), isTrue);
          expect(s.actionError, isNull);
        },
      );

      // Wait for repository call to complete
      await Future.delayed(const Duration(milliseconds: 10));

      expect(fakeRepository.declineCalled, isTrue);
      expect(fakeRepository.declinedRequestId, 'req_incoming_1');

      // Processing ID should be removed
      requestsBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.processingRequestIds.contains('req_incoming_1'), isFalse);
        },
      );
    });

    test('CancelRequest successful state transitions', () async {
      // 1. Get into loaded state
      requestsBloc.add(const RequestsEvent.started());
      await Future.delayed(const Duration(milliseconds: 10));
      fakeRepository.emitIncoming([incomingRequest]);
      fakeRepository.emitOutgoing([outgoingRequest]);
      await Future.delayed(const Duration(milliseconds: 10));

      // 2. Cancel outgoing request
      requestsBloc.add(const RequestsEvent.cancelRequest(
        requestId: 'req_outgoing_1',
      ));

      // Should optimistically add to processingRequestIds
      await Future.microtask(() {});
      requestsBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.processingRequestIds.contains('req_outgoing_1'), isTrue);
          expect(s.actionError, isNull);
        },
      );

      // Wait for repository call to complete
      await Future.delayed(const Duration(milliseconds: 10));

      expect(fakeRepository.cancelCalled, isTrue);
      expect(fakeRepository.cancelledRequestId, 'req_outgoing_1');

      // Processing ID should be removed
      requestsBloc.state.mapOrNull(
        loaded: (s) {
          expect(s.processingRequestIds.contains('req_outgoing_1'), isFalse);
        },
      );
    });
  });
}
