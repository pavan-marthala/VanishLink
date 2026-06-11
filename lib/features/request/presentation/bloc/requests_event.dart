import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/request/domain/entities/friend_request.dart';

part 'requests_event.freezed.dart';

@freezed
class RequestsEvent with _$RequestsEvent {
  const factory RequestsEvent.started() = Started;
  const factory RequestsEvent.incomingRequestsUpdated(List<FriendRequest> requests) = IncomingRequestsUpdated;
  const factory RequestsEvent.outgoingRequestsUpdated(List<FriendRequest> requests) = OutgoingRequestsUpdated;
  const factory RequestsEvent.toggleTab({required bool isIncoming}) = ToggleTab;
  const factory RequestsEvent.acceptRequest({
    required String requestId,
    required String fromUserId,
    required String toUserId,
  }) = AcceptRequest;
  const factory RequestsEvent.declineRequest({required String requestId}) = DeclineRequest;
  const factory RequestsEvent.cancelRequest({required String requestId}) = CancelRequest;
  const factory RequestsEvent.errorOccurred(String message) = ErrorOccurred;
}
