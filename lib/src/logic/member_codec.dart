import 'dart:convert';

import 'package:jc/src/model/member.dart';

const $callMemberCodec = CallMemberCodec();
const $selfCallMemberCodec = SelfCallMemberCodec();
const $conferenceMemberCodec = ConferenceMemberCodec();
const $selfConferenceMemberCodec = SelfConferenceMemberCodec();

base class CallMemberCodec extends Codec<CallMember, Map<String, Object?>> {
  const CallMemberCodec();

  @override
  Converter<Map<String, Object?>, CallMember> get decoder => const _CallMemberDecoder();

  @override
  Converter<CallMember, Map<String, Object?>> get encoder => const _CallMemberEncoder();
}

class _CallMemberDecoder extends Converter<Map<String, Object?>, CallMember> {
  const _CallMemberDecoder();

  @override
  CallMember convert(Map<String, Object?> input) => CallMember(
        video: input['video']! as bool,
        microphone: input['microphone']! as bool,
      );
}

class _CallMemberEncoder extends Converter<CallMember, Map<String, Object?>> {
  const _CallMemberEncoder();

  @override
  Map<String, Object?> convert(CallMember input) => {
        'video': input.video,
        'microphone': input.microphone,
      };
}

base class SelfCallMemberCodec extends Codec<CallSelfMember, Map<String, Object?>> {
  const SelfCallMemberCodec();

  @override
  Converter<Map<String, Object?>, CallSelfMember> get decoder => const _SelfMemberDecoder();

  @override
  Converter<CallSelfMember, Map<String, Object?>> get encoder => const _SelfMemberEncoder();
}

class _SelfMemberDecoder extends Converter<Map<String, Object?>, CallSelfMember> {
  const _SelfMemberDecoder();

  @override
  CallSelfMember convert(Map<String, Object?> input) => CallSelfMember(
        video: input['video']! as bool,
        microphone: input['microphone']! as bool,
        speaker: input['speaker']! as bool,
      );
}

class _SelfMemberEncoder extends Converter<CallSelfMember, Map<String, Object?>> {
  const _SelfMemberEncoder();

  @override
  Map<String, Object?> convert(CallSelfMember input) => {
        'video': input.video,
        'microphone': input.microphone,
        'speaker': input.speaker,
      };
}

base class SelfConferenceMemberCodec extends Codec<ConferenceSelfMember, Map<String, Object?>> {
  const SelfConferenceMemberCodec();

  @override
  Converter<Map<String, Object?>, ConferenceSelfMember> get decoder =>
      const _SelfConferenceMemberDecoder();

  @override
  Converter<ConferenceSelfMember, Map<String, Object?>> get encoder =>
      const _SelfConferenceMemberEncoder();
}

class _SelfConferenceMemberDecoder extends Converter<Map<String, Object?>, ConferenceSelfMember> {
  const _SelfConferenceMemberDecoder();

  @override
  ConferenceSelfMember convert(Map<String, Object?> input) => ConferenceSelfMember(
        video: input['video']! as bool,
        microphone: input['microphone']! as bool,
        speaker: input['speaker']! as bool,
        uid: input['uid']! as String,
      );
}

class _SelfConferenceMemberEncoder extends Converter<ConferenceSelfMember, Map<String, Object?>> {
  const _SelfConferenceMemberEncoder();

  @override
  Map<String, Object?> convert(ConferenceSelfMember input) => {
        'uid': input.uid,
        'video': input.video,
        'microphone': input.microphone,
        'speaker': input.speaker,
      };
}

base class ConferenceMemberCodec extends Codec<ConferenceMember, Map<String, Object?>> {
  const ConferenceMemberCodec();

  @override
  Converter<Map<String, Object?>, ConferenceMember> get decoder => const _ConferenceMemberDecoder();

  @override
  Converter<ConferenceMember, Map<String, Object?>> get encoder => const _ConferenceMemberEncoder();
}

class _ConferenceMemberDecoder extends Converter<Map<String, Object?>, ConferenceMember> {
  const _ConferenceMemberDecoder();

  @override
  ConferenceMember convert(Map<String, Object?> input) => ConferenceMember(
        uid: input['uid']! as String,
        video: input['video']! as bool,
        microphone: input['microphone']! as bool,
      );
}

class _ConferenceMemberEncoder extends Converter<ConferenceMember, Map<String, Object?>> {
  const _ConferenceMemberEncoder();

  @override
  Map<String, Object?> convert(ConferenceMember input) => {
        'uid': input.uid,
        'video': input.video,
        'microphone': input.microphone,
      };
}
