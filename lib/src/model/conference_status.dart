/// The status of a conference.
enum ConferenceStatus {
  /// The conference is not yet joined.
  off,

  /// The conference is joined, but nobody is here.
  waiting,

  /// The conference is joined, and at least one person is here.
  on;

  /// Converts a string to a [ConferenceStatus].
  static ConferenceStatus fromString(String status) => switch (status) {
        'off' => ConferenceStatus.off,
        'waiting' => ConferenceStatus.waiting,
        'on' => ConferenceStatus.on,
        _ => throw ArgumentError('Invalid status: $status'),
      };
}
