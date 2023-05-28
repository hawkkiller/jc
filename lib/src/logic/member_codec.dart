import 'dart:convert';

import 'package:jc/src/model/member.dart';

const $memberCodec = MemberCodec();
const $selfMemberCodec = SelfMemberCodec();

base class MemberCodec extends Codec<Member, Map<String, Object?>> {
  const MemberCodec();

  @override
  Converter<Map<String, Object?>, Member> get decoder => const _MemberDecoder();

  @override
  Converter<Member, Map<String, Object?>> get encoder => const _MemberEncoder();
}

class _MemberDecoder extends Converter<Map<String, Object?>, Member> {
  const _MemberDecoder();

  @override
  Member convert(Map<String, Object?> input) => Member(
        video: input['video']! as bool,
        microphone: input['microphone']! as bool,
      );
}

class _MemberEncoder extends Converter<Member, Map<String, Object?>> {
  const _MemberEncoder();

  @override
  Map<String, Object?> convert(Member input) => {
        'video': input.video,
        'microphone': input.microphone,
      };
}

base class SelfMemberCodec extends Codec<SelfMember, Map<String, Object?>> {
  const SelfMemberCodec();

  @override
  Converter<Map<String, Object?>, SelfMember> get decoder => const _SelfMemberDecoder();

  @override
  Converter<SelfMember, Map<String, Object?>> get encoder => const _SelfMemberEncoder();
}

class _SelfMemberDecoder extends Converter<Map<String, Object?>, SelfMember> {
  const _SelfMemberDecoder();

  @override
  SelfMember convert(Map<String, Object?> input) => SelfMember(
        video: input['video']! as bool,
        microphone: input['microphone']! as bool,
        speaker: input['speaker']! as bool,
      );
}

class _SelfMemberEncoder extends Converter<SelfMember, Map<String, Object?>> {
  const _SelfMemberEncoder();

  @override
  Map<String, Object?> convert(SelfMember input) => {
        'video': input.video,
        'microphone': input.microphone,
        'speaker': input.speaker,
      };
}
