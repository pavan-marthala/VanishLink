import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/request/domain/entities/friend_request.dart';
import 'package:vanish_link/features/request/domain/repositories/request_repository.dart';
import 'requests_event.dart';
import 'requests_state.dart';

export 'requests_event.dart';
export 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  final RequestRepository _requestRepository;
  StreamSubscription<List<FriendRequest>>? _incomingSub;
  StreamSubscription<List<FriendRequest>>? _outgoingSub;

  RequestsBloc({required RequestRepository requestRepository})
      : _requestRepository = requestRepository,
        super(const RequestsState.initial()) {
    
    on<Started>((event, emit) {
      emit(const RequestsState.loading());

      _incomingSub?.cancel();
      _incomingSub = _requestRepository.watchIncomingRequests().listen(
        (requests) => add(RequestsEvent.incomingRequestsUpdated(requests)),
        onError: (e) => add(RequestsEvent.errorOccurred(e.toString())),
      );

      _outgoingSub?.cancel();
      _outgoingSub = _requestRepository.watchOutgoingRequests().listen(
        (requests) => add(RequestsEvent.outgoingRequestsUpdated(requests)),
        onError: (e) => add(RequestsEvent.errorOccurred(e.toString())),
      );
    });

    on<IncomingRequestsUpdated>((event, emit) {
      state.maybeMap(
        loaded: (loadedState) {
          emit(loadedState.copyWith(incomingRequests: event.requests, actionError: null));
        },
        orElse: () {
          emit(RequestsState.loaded(
            incomingRequests: event.requests,
            outgoingRequests: const [],
            isIncomingTab: true,
            processingRequestIds: const {},
          ));
        },
      );
    });

    on<OutgoingRequestsUpdated>((event, emit) {
      state.maybeMap(
        loaded: (loadedState) {
          emit(loadedState.copyWith(outgoingRequests: event.requests, actionError: null));
        },
        orElse: () {
          emit(RequestsState.loaded(
            incomingRequests: const [],
            outgoingRequests: event.requests,
            isIncomingTab: true,
            processingRequestIds: const {},
          ));
        },
      );
    });

    on<ToggleTab>((event, emit) {
      state.mapOrNull(
        loaded: (loadedState) {
          emit(loadedState.copyWith(isIncomingTab: event.isIncoming, actionError: null));
        },
      );
    });

    on<AcceptRequest>((event, emit) async {
      final currentState = state;
      if (currentState is! RequestsLoaded) return;

      final updatedProcessing = Set<String>.from(currentState.processingRequestIds)..add(event.requestId);
      emit(currentState.copyWith(processingRequestIds: updatedProcessing, actionError: null));

      try {
        await _requestRepository.acceptRequest(
          event.requestId,
          event.fromUserId,
          event.toUserId,
        );
        
        final resultsState = state;
        if (resultsState is RequestsLoaded) {
          final finalProcessing = Set<String>.from(resultsState.processingRequestIds)..remove(event.requestId);
          emit(resultsState.copyWith(processingRequestIds: finalProcessing));
        }
      } catch (e) {
        final resultsState = state;
        if (resultsState is RequestsLoaded) {
          final finalProcessing = Set<String>.from(resultsState.processingRequestIds)..remove(event.requestId);
          emit(resultsState.copyWith(
            processingRequestIds: finalProcessing,
            actionError: 'Failed to accept request. Please try again.',
          ));
        }
      }
    });

    on<DeclineRequest>((event, emit) async {
      final currentState = state;
      if (currentState is! RequestsLoaded) return;

      final updatedProcessing = Set<String>.from(currentState.processingRequestIds)..add(event.requestId);
      emit(currentState.copyWith(processingRequestIds: updatedProcessing, actionError: null));

      try {
        await _requestRepository.declineRequest(event.requestId);
        
        final resultsState = state;
        if (resultsState is RequestsLoaded) {
          final finalProcessing = Set<String>.from(resultsState.processingRequestIds)..remove(event.requestId);
          emit(resultsState.copyWith(processingRequestIds: finalProcessing));
        }
      } catch (e) {
        final resultsState = state;
        if (resultsState is RequestsLoaded) {
          final finalProcessing = Set<String>.from(resultsState.processingRequestIds)..remove(event.requestId);
          emit(resultsState.copyWith(
            processingRequestIds: finalProcessing,
            actionError: 'Failed to decline request. Please try again.',
          ));
        }
      }
    });

    on<CancelRequest>((event, emit) async {
      final currentState = state;
      if (currentState is! RequestsLoaded) return;

      final updatedProcessing = Set<String>.from(currentState.processingRequestIds)..add(event.requestId);
      emit(currentState.copyWith(processingRequestIds: updatedProcessing, actionError: null));

      try {
        await _requestRepository.cancelRequest(event.requestId);
        
        final resultsState = state;
        if (resultsState is RequestsLoaded) {
          final finalProcessing = Set<String>.from(resultsState.processingRequestIds)..remove(event.requestId);
          emit(resultsState.copyWith(processingRequestIds: finalProcessing));
        }
      } catch (e) {
        final resultsState = state;
        if (resultsState is RequestsLoaded) {
          final finalProcessing = Set<String>.from(resultsState.processingRequestIds)..remove(event.requestId);
          emit(resultsState.copyWith(
            processingRequestIds: finalProcessing,
            actionError: 'Failed to cancel request. Please try again.',
          ));
        }
      }
    });

    on<ErrorOccurred>((event, emit) {
      emit(RequestsState.error(event.message));
    });
  }

  @override
  Future<void> close() {
    _incomingSub?.cancel();
    _outgoingSub?.cancel();
    return super.close();
  }
}
