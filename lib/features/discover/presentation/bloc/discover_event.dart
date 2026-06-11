import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_event.freezed.dart';

@freezed
class DiscoverEvent with _$DiscoverEvent {
  const factory DiscoverEvent.searchQueryChanged(String query) = SearchQueryChanged;
  const factory DiscoverEvent.searchStarted() = SearchStarted;
  const factory DiscoverEvent.userSelected(String userId) = UserSelected;
  const factory DiscoverEvent.sendFriendRequest({
    required String targetUserId,
  }) = SendFriendRequest;
}
