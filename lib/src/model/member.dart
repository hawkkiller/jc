/// The member in a conference | call.
base class Member {
  const Member({
    required this.id,
    required this.name,
    required this.videoEnabled,
    required this.microphoneEnabled,
  });

  /// The ID of the member in the conference.
  final String id;

  /// The name of the member.
  final String name;

  /// Whether the video of the member is enabled.
  final bool videoEnabled;

  /// Whether the member is muted.
  final bool microphoneEnabled;
}

/// The member in a conference | call.
base class SelfMember extends Member {
  const SelfMember({
    required super.id,
    required super.name,
    required super.videoEnabled,
    required super.microphoneEnabled,
    required this.speakerEnabled,
  });

  /// Whether the speaker of the member is enabled.
  final bool speakerEnabled;
}
