import 'dart:convert';

import 'package:jc/src/model/member.dart';

const $callMemberCodec = CallMemberCodec();
const $selfCallMemberCodec = SelfCallMemberCodec();

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
