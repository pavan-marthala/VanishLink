import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/discover/domain/repositories/discover_repository.dart';

part 'discover_state.freezed.dart';

@freezed
class DiscoverState with _$DiscoverState {
  const factory DiscoverState.initial() = _Initial;
  const factory DiscoverState.searching() = _Searching;
  const factory DiscoverState.results({
    required List<UserProfile> users,
    required Map<String, FriendshipStatus> friendshipStatuses,
    required Set<String> sendingRequestUserIds,
    required Map<String, String?> actionErrors,
  }) = DiscoverResults;
  const factory DiscoverState.empty() = _Empty;
  const factory DiscoverState.error(String message) = _Error;
}
