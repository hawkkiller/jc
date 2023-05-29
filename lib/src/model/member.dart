/// The member in a conference | call.
base class Member {
  const Member({
    required this.video,
    required this.microphone,
  });

  /// Whether the video of the member is enabled.
  final bool video;

  /// Whether the member is muted.
  final bool microphone;

  @override
  String toString() => 'Member(video: $video, microphone: $microphone)';
}

/// The member in a conference | call.
base class SelfMember extends Member {
  const SelfMember({
    required super.video,
    required super.microphone,
    required this.speaker,
  });

  /// Whether the speaker of the member is enabled.
  final bool speaker;

  @override
  String toString() => 'SelfMember(video: $video, microphone: $microphone, speaker: $speaker)';
}
