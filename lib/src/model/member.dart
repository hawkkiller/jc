/// The member in a conference | call.
abstract interface class Member {
  const Member();

  /// Whether the video of the member is enabled.
  bool get video;

  /// Whether the member is muted.
  bool get microphone;
}

/// The member in a conference | call.
abstract mixin class SelfMember implements Member {
  /// Whether the speaker of the member is enabled.
  bool get speaker;
}

base class CallMember extends Member {
  const CallMember({
    required this.video,
    required this.microphone,
  });

  @override
  final bool microphone;

  @override
  final bool video;

  @override
  String toString() => 'CallSelfMember(video: $video, microphone: $microphone)';
}

base class CallSelfMember extends CallMember with SelfMember {
  const CallSelfMember({
    required super.video,
    required super.microphone,
    required this.speaker,
  });

  @override
  final bool speaker;
  
  @override
  String toString() => 'CallSelfMember(video: $video, microphone: $microphone, speaker: $speaker)';
}

base class ConferenceMember extends Member {
  const ConferenceMember({
    required this.video,
    required this.microphone,
    required this.conferenceId,
    required this.memberId,
  });

  /// The conference | call ID.
  final String conferenceId;

  /// The member ID.
  final String memberId;

  @override
  final bool video;

  @override
  final bool microphone;

  @override
  String toString() =>
      'ConferenceMember(video: $video, microphone: $microphone, conferenceId: $conferenceId, memberId: $memberId)';
}

base class ConferenceSelfMember extends ConferenceMember with SelfMember {
  const ConferenceSelfMember({
    required super.video,
    required super.microphone,
    required super.conferenceId,
    required super.memberId,
    required this.speaker,
  });

  @override
  String toString() =>
      'ConferenceSelfMember(video: $video, microphone: $microphone, speaker: $speaker, conferenceId: $conferenceId, memberId: $memberId)';

  @override
  final bool speaker;
}
