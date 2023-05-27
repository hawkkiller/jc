import 'dart:convert';

import 'package:jc/src/model/member.dart';

const $memberCodec = MemberCodec();
const $selfMemberCodec = SelfMemberCodec();

base class MemberCodec extends Codec<Member, List<Object>> {
  const MemberCodec();

  @override
  Converter<List<Object>, Member> get decoder => const _MemberDecoder();

  @override
  Converter<Member, List<Object>> get encoder => const _MemberEncoder();
}

class _MemberDecoder extends Converter<List<Object>, Member> {
  const _MemberDecoder();

  @override
  Member convert(List<Object> input) => Member(
        id: input[0] as String,
        name: input[1] as String,
        videoEnabled: input[2] as bool,
        microphoneEnabled: input[3] as bool,
      );
}

class _MemberEncoder extends Converter<Member, List<Object>> {
  const _MemberEncoder();

  @override
  List<Object> convert(Member input) => <Object>[
        input.id,
        input.name,
        input.videoEnabled,
        input.microphoneEnabled,
      ];
}

base class SelfMemberCodec extends Codec<SelfMember, List<Object>> {
  const SelfMemberCodec();

  @override
  Converter<List<Object>, SelfMember> get decoder => const _SelfMemberDecoder();

  @override
  Converter<SelfMember, List<Object>> get encoder => const _SelfMemberEncoder();
}

class _SelfMemberDecoder extends Converter<List<Object>, SelfMember> {
  const _SelfMemberDecoder();

  @override
  SelfMember convert(List<Object> input) => SelfMember(
        id: input[0] as String,
        name: input[1] as String,
        videoEnabled: input[2] as bool,
        microphoneEnabled: input[3] as bool,
        speakerEnabled: input[4] as bool,
      );
}

class _SelfMemberEncoder extends Converter<SelfMember, List<Object>> {
  const _SelfMemberEncoder();

  @override
  List<Object> convert(SelfMember input) => <Object>[
        input.id,
        input.name,
        input.videoEnabled,
        input.microphoneEnabled,
        input.speakerEnabled,
      ];
}
