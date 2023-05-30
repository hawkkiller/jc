import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:jc/src/logic/member_codec.dart';
import 'package:jc/src/model/conference_status.dart';
import 'package:jc/src/model/member.dart';
import 'package:stream_transform/stream_transform.dart';

abstract interface class JcConferenceStateChannel {
  /// Stream of members in the conference.
  ///
  /// This stream emits a list of members every time the list or properties changes.
  ///
  /// **Note:** This stream does not contain self member.
  Stream<List<ConferenceMember>> get members;

  /// Stream of self member in the conference.
  ///
  /// This stream emits a new model of member every time the status or properties changes.
    Stream<ConferenceSelfMember> get selfMember;

  /// Stream of conference status changes.
  ///
  /// This stream emits a new model of conference status every time the status changes.
  Stream<ConferenceStatus> get status;
}

base class JcConferenceStateChannelBase implements JcConferenceStateChannel {
  JcConferenceStateChannelBase() {
    _jcConferenceStateEventChannelSelf = const EventChannel(
      'lazebny.io.jc/jc_conference_state_channel/self',
    );
    _jcConferenceStateEventChannelOther = const EventChannel(
      'lazebny.io.jc/jc_conference_state_channel/members',
    );
    _jcConferenceStateEventChannelStatus = const EventChannel(
      'lazebny.io.jc/jc_conference_state_channel/status',
    );

    members = _jcConferenceStateEventChannelOther
        .receiveBroadcastStream()
        .whereType<List<Object>>()
        .asyncMap<List<ConferenceMember>>(
          (event) => Stream.fromIterable(event)
              .asyncMap(
                (event) => Future.value(
                  $conferenceMemberCodec.decode(event as Map<String, Object?>),
                ),
              )
              .toList(),
        );

    selfMember = _jcConferenceStateEventChannelSelf
        .receiveBroadcastStream()
        .whereType<Map<Object?, Object?>>()
        .map((event) => event.cast<String, Object?>())
        .map($selfConferenceMemberCodec.decode);

    status = _jcConferenceStateEventChannelStatus
        .receiveBroadcastStream()
        .whereType<String>()
        .map(ConferenceStatus.fromString);
  }

  late final EventChannel _jcConferenceStateEventChannelSelf;
  late final EventChannel _jcConferenceStateEventChannelOther;
  late final EventChannel _jcConferenceStateEventChannelStatus;

  @override
  late final Stream<List<ConferenceMember>> members;

  @override
  late final Stream<ConferenceSelfMember> selfMember;

  @override
  late final Stream<ConferenceStatus> status;
}
