enum CallStatus {
  off,
  waiting,
  on;

  static CallStatus fromString(String status) => switch (status) {
        'off' => CallStatus.off,
        'waiting' => CallStatus.waiting,
        'on' => CallStatus.on,
        _ => throw ArgumentError('Invalid status: $status'),
      };
}
