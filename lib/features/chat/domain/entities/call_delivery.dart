enum CallDeliveryStatus {
  created,
  delivering,
  ringing,
  accepted,
  declined,
  cancelled,
  missed,
  timeout,
  unreachable,
}

class CallDeliveryConfig {
  /// Timeout to transition from created -> delivering/ringing before assuming recipient is unreachable.
  static const Duration deliveringTimeout = Duration(seconds: 10);

  /// Timeout to answer the call once it starts ringing before marking it as missed.
  static const Duration ringingTimeout = Duration(seconds: 30);
}
