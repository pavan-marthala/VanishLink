import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vanish_link/features/chat/domain/entities/presence_status.dart';

part 'presence_event.freezed.dart';

@freezed
class PresenceEvent with _$PresenceEvent {
  const factory PresenceEvent.monitorUser(String userId) = MonitorUser;
  const factory PresenceEvent.presenceUpdated(PresenceStatus status) = PresenceUpdated;
}
