enum CallStatus {
  /// Call is off.
  off,
  /// Call is waiting for other member to join.
  waiting,
  /// Call is in progress.
  on;

  /// Converts a string to a [CallStatus].
  static CallStatus fromString(String status) => switch (status) {
        'off' => CallStatus.off,
        'waiting' => CallStatus.waiting,
        'on' => CallStatus.on,
        _ => throw ArgumentError('Invalid status: $status'),
      };
}
