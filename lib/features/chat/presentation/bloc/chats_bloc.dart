import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/discover/domain/entities/user_profile.dart';
import 'package:vanish_link/features/chat/domain/repositories/chat_repository.dart';
import 'chats_event.dart';
import 'chats_state.dart';

export 'chats_event.dart';
export 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatRepository _chatRepository;
  StreamSubscription<List<UserProfile>>? _contactsSub;

  ChatsBloc({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(const ChatsState.initial()) {
    
    on<Started>((event, emit) {
      emit(const ChatsState.loading());
      _contactsSub?.cancel();
      _contactsSub = _chatRepository.watchContacts().listen(
        (contacts) => add(ChatsEvent.contactsUpdated(contacts)),
        onError: (e) => emit(ChatsState.error(e.toString())),
      );
    });

    on<ContactsUpdated>((event, emit) {
      final query = state.maybeMap(
        loaded: (s) => s.searchQuery,
        orElse: () => '',
      );

      final filtered = _filterContacts(event.contacts, query);
      emit(ChatsState.loaded(
        allContacts: event.contacts,
        filteredContacts: filtered,
        searchQuery: query,
      ));
    });

    on<SearchQueryChanged>((event, emit) {
      state.maybeMap(
        loaded: (s) {
          final filtered = _filterContacts(s.allContacts, event.query);
          emit(s.copyWith(
            filteredContacts: filtered,
            searchQuery: event.query,
          ));
        },
        orElse: () {},
      );
    });
  }

  List<UserProfile> _filterContacts(List<UserProfile> contacts, String query) {
    if (query.isEmpty) return contacts;
    final normalizedQuery = query.toLowerCase().trim();
    return contacts.where((c) {
      final nameMatches = c.displayName.toLowerCase().contains(normalizedQuery);
      final usernameMatches = c.username.toLowerCase().contains(normalizedQuery);
      return nameMatches || usernameMatches;
    }).toList();
  }

  @override
  Future<void> close() {
    _contactsSub?.cancel();
    return super.close();
  }
}
