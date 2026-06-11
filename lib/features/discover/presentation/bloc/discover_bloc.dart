import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/discover/domain/repositories/discover_repository.dart';
import 'discover_event.dart';
import 'discover_state.dart';

export 'discover_event.dart';
export 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final DiscoverRepository _discoverRepository;
  Timer? _searchDebounceTimer;
  String _currentQuery = '';

  DiscoverBloc({required DiscoverRepository discoverRepository})
      : _discoverRepository = discoverRepository,
        super(const DiscoverState.initial()) {
    
    on<SearchQueryChanged>((event, emit) {
      final query = event.query.trim();
      _currentQuery = query;

      _searchDebounceTimer?.cancel();

      if (query.isEmpty) {
        emit(const DiscoverState.initial());
      } else {
        _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
          add(const DiscoverEvent.searchStarted());
        });
      }
    });

    on<SearchStarted>((event, emit) async {
      if (_currentQuery.isEmpty) return;

      emit(const DiscoverState.searching());

      try {
        final users = await _discoverRepository.searchUsers(
          query: _currentQuery,
        );

        if (users.isEmpty) {
          emit(const DiscoverState.empty());
        } else {
          // Fetch friendship status for each user in parallel
          final statuses = await Future.wait(
            users.map((u) => _discoverRepository.checkFriendshipStatus(targetUserId: u.userId)),
          );

          final Map<String, FriendshipStatus> friendshipStatuses = {};
          for (var i = 0; i < users.length; i++) {
            friendshipStatuses[users[i].userId] = statuses[i];
          }

          emit(DiscoverState.results(
            users: users,
            friendshipStatuses: friendshipStatuses,
            sendingRequestUserIds: const {},
            actionErrors: const {},
          ));
        }
      } catch (e) {
        emit(DiscoverState.error('An error occurred during search. Please try again.'));
      }
    });

    on<SendFriendRequest>((event, emit) async {
      final currentState = state;
      if (currentState is! DiscoverResults) return;

      final targetUserId = event.targetUserId;
      if (currentState.sendingRequestUserIds.contains(targetUserId)) return;

      // Optimistically add user ID to sendingRequestUserIds set and clear previous action error
      final updatedSending = Set<String>.from(currentState.sendingRequestUserIds)..add(targetUserId);
      final updatedErrors = Map<String, String?>.from(currentState.actionErrors)..remove(targetUserId);

      emit(currentState.copyWith(
        sendingRequestUserIds: updatedSending,
        actionErrors: updatedErrors,
      ));

      try {
        await _discoverRepository.sendFriendRequest(targetUserId: targetUserId);

        // Fetch the updated friendship status
        final newStatus = await _discoverRepository.checkFriendshipStatus(targetUserId: targetUserId);

        final resultsState = state;
        if (resultsState is DiscoverResults) {
          final updatedStatuses = Map<String, FriendshipStatus>.from(resultsState.friendshipStatuses)
            ..[targetUserId] = newStatus;
          final finalSending = Set<String>.from(resultsState.sendingRequestUserIds)..remove(targetUserId);

          emit(resultsState.copyWith(
            friendshipStatuses: updatedStatuses,
            sendingRequestUserIds: finalSending,
          ));
        }
      } catch (e) {
        final errorMessage = e.toString();
        final actionError = errorMessage.contains('yourself')
            ? 'You cannot send a friend request to yourself.'
            : 'Failed to send friend request. Please try again.';

        final resultsState = state;
        if (resultsState is DiscoverResults) {
          final finalSending = Set<String>.from(resultsState.sendingRequestUserIds)..remove(targetUserId);
          final finalErrors = Map<String, String?>.from(resultsState.actionErrors)
            ..[targetUserId] = actionError;

          emit(resultsState.copyWith(
            sendingRequestUserIds: finalSending,
            actionErrors: finalErrors,
          ));
        }
      }
    });

    on<UserSelected>((event, emit) {
      // Handled inline now.
    });
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }
}
