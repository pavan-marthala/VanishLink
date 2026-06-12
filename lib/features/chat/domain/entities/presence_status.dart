class PresenceStatus {
  final bool online;
  final DateTime lastSeen;

  const PresenceStatus({
    required this.online,
    required this.lastSeen,
  });

  factory PresenceStatus.offline() => PresenceStatus(
        online: false,
        lastSeen: DateTime.fromMillisecondsSinceEpoch(0),
      );
}
