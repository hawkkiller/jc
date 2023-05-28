import 'package:flutter/services.dart';
import 'package:jc/src/logic/member_codec.dart';
import 'package:jc/src/model/member.dart';
import 'package:stream_transform/stream_transform.dart';

abstract interface class JcCallStateChannel {
  /// Stream of other member in the call.
  /// 
  /// This stream emits a new model of member every time the status or properties changes.
  Stream<Member> get otherMember;

  Stream<SelfMember> get selfMember;
}

base class JcCallStateChannelBase implements JcCallStateChannel {
  JcCallStateChannelBase() {
    _jcCallStateChannelSelf = const EventChannel(
      'lazebny.io.jc/jc_call_state_channel/self',
    );
    _jcCallStateChannelOther = const EventChannel(
      'lazebny.io.jc/jc_call_state_channel/other',
    );

    otherMember = _jcCallStateChannelOther
        .receiveBroadcastStream()
        .whereType<Map<String, Object?>>()
        .map($memberCodec.decode);
    
    selfMember = _jcCallStateChannelSelf
        .receiveBroadcastStream()
        .whereType<Map<String, Object?>>()
        .map($selfMemberCodec.decode);
  }

  late final EventChannel _jcCallStateChannelSelf;
  late final EventChannel _jcCallStateChannelOther;

  @override
  late final Stream<Member> otherMember;

  @override
  late final Stream<SelfMember> selfMember;
}
