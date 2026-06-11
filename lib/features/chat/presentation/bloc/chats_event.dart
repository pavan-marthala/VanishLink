import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';

part 'chats_event.freezed.dart';

@freezed
class ChatsEvent with _$ChatsEvent {
  const factory ChatsEvent.started() = Started;
  const factory ChatsEvent.contactsUpdated(List<UserProfile> contacts) = ContactsUpdated;
  const factory ChatsEvent.searchQueryChanged(String query) = SearchQueryChanged;
}
