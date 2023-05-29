import 'package:flutter/services.dart';
import 'package:jc/src/logic/member_codec.dart';
import 'package:jc/src/model/call_status.dart';
import 'package:jc/src/model/member.dart';
import 'package:stream_transform/stream_transform.dart';

abstract interface class JcCallStateChannel {
  /// Stream of other member in the call.
  ///
  /// This stream emits a new model of member every time the status or properties changes.
  Stream<Member> get otherMember;

  /// Stream of self member in the call.
  ///
  /// This stream emits a new model of member every time the status or properties changes.
  Stream<SelfMember> get selfMember;

  /// Stream of call status changes.
  ///
  /// This stream emits a new model of call status every time the status changes.
  Stream<CallStatus> get status;
}

base class JcCallStateChannelBase implements JcCallStateChannel {
  JcCallStateChannelBase() {
    _jcCallStateChannelSelf = const EventChannel(
      'lazebny.io.jc/jc_call_state_channel/self',
    );
    _jcCallStateChannelOther = const EventChannel(
      'lazebny.io.jc/jc_call_state_channel/other',
    );
    _jcCallStateChannelStatus = const EventChannel(
      'lazebny.io.jc/jc_call_state_channel/status',
    );

    otherMember = _jcCallStateChannelOther
        .receiveBroadcastStream()
        .whereType<Map<Object?, Object?>>()
        .map((event) => event.cast<String, Object?>())
        .map($memberCodec.decode);

    selfMember = _jcCallStateChannelSelf
        .receiveBroadcastStream()
        .whereType<Map<Object?, Object?>>()
        .map((event) => event.cast<String, Object?>())
        .map($selfMemberCodec.decode);
    status = _jcCallStateChannelStatus
        .receiveBroadcastStream()
        .whereType<String>()
        .map(CallStatus.fromString);
  }

  late final EventChannel _jcCallStateChannelSelf;
  late final EventChannel _jcCallStateChannelOther;
  late final EventChannel _jcCallStateChannelStatus;

  @override
  late final Stream<CallStatus> status;

  @override
  late final Stream<Member> otherMember;

  @override
  late final Stream<SelfMember> selfMember;
}
