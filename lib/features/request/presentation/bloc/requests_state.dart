import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/request/domain/entities/friend_request.dart';

part 'requests_state.freezed.dart';

@freezed
class RequestsState with _$RequestsState {
  const factory RequestsState.initial() = _Initial;
  const factory RequestsState.loading() = _Loading;
  const factory RequestsState.loaded({
    required List<FriendRequest> incomingRequests,
    required List<FriendRequest> outgoingRequests,
    required bool isIncomingTab,
    required Set<String> processingRequestIds,
    String? actionError,
  }) = RequestsLoaded;
  const factory RequestsState.error(String message) = _Error;
}
