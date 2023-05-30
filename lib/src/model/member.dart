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
    required this.uid,
  });

  /// The user ID.
  final String uid;

  @override
  final bool video;

  @override
  final bool microphone;

  @override
  String toString() =>
      'ConferenceMember(video: $video, microphone: $microphone, uid: $uid)';
}

base class ConferenceSelfMember extends ConferenceMember with SelfMember {
  const ConferenceSelfMember({
    required super.video,
    required super.microphone,
    required super.uid,
    required this.speaker,
  });

  @override
  String toString() =>
      'ConferenceSelfMember(video: $video, microphone: $microphone, speaker: $speaker, uid: $uid)';

  @override
  final bool speaker;
}
