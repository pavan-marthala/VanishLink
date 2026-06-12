enum PresenceStatusType {
  online,
  background,
  offline,
}

class PresenceStatus {
  final PresenceStatusType status;
  final bool online; // Deprecated but preserved for backward compatibility
  final DateTime lastSeen;

  const PresenceStatus({
    PresenceStatusType? status,
    required this.online,
    required this.lastSeen,
  }) : status = status ?? (online ? PresenceStatusType.online : PresenceStatusType.offline);

  factory PresenceStatus.offline() => PresenceStatus(
        status: PresenceStatusType.offline,
        online: false,
        lastSeen: DateTime.fromMillisecondsSinceEpoch(0),
      );
}
