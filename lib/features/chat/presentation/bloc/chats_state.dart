import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

part 'chats_state.freezed.dart';

@freezed
class ChatsState with _$ChatsState {
  const factory ChatsState.initial() = _Initial;
  const factory ChatsState.loading() = _Loading;
  const factory ChatsState.loaded({
    required List<UserProfile> allContacts,
    required List<UserProfile> filteredContacts,
    required String searchQuery,
  }) = ChatsLoaded;
  const factory ChatsState.error(String message) = _Error;
}
