import 'package:flutter/services.dart';
import 'package:jc/src/logic/member_codec.dart';
import 'package:jc/src/model/member.dart';
import 'package:stream_transform/stream_transform.dart';

abstract interface class JcConferenceStateChannel {
  /// Stream of members in the conference.
  ///
  /// This stream emits a list of members every time the list or properties changes.
  ///
  /// **Note:** This stream does not contain self member.
  Stream<List<Member>> get members;

  /// Stream of self member in the conference.
  Stream<SelfMember> get selfMember;
}

base class JcConferenceStateChannelBase implements JcConferenceStateChannel {
  JcConferenceStateChannelBase() {
    _jcCallStateEventChannelSelf = const EventChannel(
      'lazebny.io.jc/jc_call_state_channel',
    );
    _jcCallStateEventChannelOther = const EventChannel(
      'lazebny.io.jc/jc_conference_state_channel',
    );

    members = _jcCallStateEventChannelOther
        .receiveBroadcastStream()
        .whereType<List<Object>>()
        .asyncMap<List<Member>>(
          (event) => Stream.fromIterable(event)
              .asyncMap((event) => Future.value($memberCodec.decode(event as Map<String, Object?>)))
              .toList(),
        );

    selfMember = _jcCallStateEventChannelSelf
        .receiveBroadcastStream()
        .whereType<Map<String, Object?>>()
        .map($selfMemberCodec.decode);
  }

  late final EventChannel _jcCallStateEventChannelSelf;
  late final EventChannel _jcCallStateEventChannelOther;

  @override
  late final Stream<List<Member>> members;

  @override
  late final Stream<SelfMember> selfMember;
}
