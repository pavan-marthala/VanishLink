import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanish_link/features/chat/domain/repositories/presence_repository.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';
import 'presence_event.dart';
import 'presence_state.dart';

export 'presence_event.dart';
export 'presence_state.dart';

class PresenceBloc extends Bloc<PresenceEvent, PresenceState> {
  final PresenceRepository _presenceRepository;
  StreamSubscription<PresenceStatus>? _presenceSub;

  PresenceBloc({required PresenceRepository presenceRepository})
      : _presenceRepository = presenceRepository,
        super(const PresenceState.unknown()) {
    on<MonitorUser>((event, emit) {
      _presenceSub?.cancel();
      if (event.userId.isEmpty || event.userId.startsWith('dummy_')) {
        emit(const PresenceState.unknown());
        return;
      }
      _presenceSub = _presenceRepository.watchPresence(event.userId).listen(
        (status) {
          if (!isClosed) {
            add(PresenceEvent.presenceUpdated(status));
          }
        },
        onError: (_) {
          if (!isClosed) {
            add(PresenceEvent.presenceUpdated(PresenceStatus.offline()));
          }
        },
      );
    });

    on<PresenceUpdated>((event, emit) {
      if (event.status.status == PresenceStatusType.online) {
        emit(const PresenceState.online());
      } else if (event.status.status == PresenceStatusType.background) {
        emit(const PresenceState.background());
      } else if (event.status.lastSeen.millisecondsSinceEpoch == 0) {
        emit(const PresenceState.unknown());
      } else {
        emit(PresenceState.offline(lastSeen: event.status.lastSeen));
      }
    });
  }

  @override
  Future<void> close() {
    _presenceSub?.cancel();
    return super.close();
  }
}
