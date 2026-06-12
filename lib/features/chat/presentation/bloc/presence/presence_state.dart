import 'package:freezed_annotation/freezed_annotation.dart';

part 'presence_state.freezed.dart';

@freezed
class PresenceState with _$PresenceState {
  const factory PresenceState.unknown() = Unknown;
  const factory PresenceState.online() = Online;
  const factory PresenceState.background() = Background;
  const factory PresenceState.offline({required DateTime lastSeen}) = Offline;
}

extension PresenceStateX on PresenceState {
  bool get isOnline => maybeMap(
        online: (_) => true,
        background: (_) => true,
        orElse: () => false,
      );

  String get displayStatus => map(
        unknown: (_) => 'Offline',
        online: (_) => 'Online',
        background: (_) => 'Away',
        offline: (o) {
          if (o.lastSeen.millisecondsSinceEpoch == 0) {
            return 'Offline';
          }
          final diff = DateTime.now().difference(o.lastSeen);
          if (diff.isNegative) return 'Last seen just now';
          if (diff.inSeconds < 60) return 'Last seen just now';
          if (diff.inMinutes < 60) return 'Last seen ${diff.inMinutes}m ago';
          if (diff.inHours < 24) return 'Last seen ${diff.inHours}h ago';
          return 'Last seen offline';
        },
      );
}
