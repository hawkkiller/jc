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
        id: input['id']! as String,
        name: input['name']! as String,
        videoEnabled: input['videoEnabled']! as bool,
        microphoneEnabled: input['microphoneEnabled']! as bool,
      );
}

class _MemberEncoder extends Converter<Member, Map<String, Object?>> {
  const _MemberEncoder();

  @override
  Map<String, Object?> convert(Member input) => {
        'id': input.id,
        'name': input.name,
        'videoEnabled': input.videoEnabled,
        'microphoneEnabled': input.microphoneEnabled,
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
        id: input['id']! as String,
        name: input['name']! as String,
        videoEnabled: input['videoEnabled']! as bool,
        microphoneEnabled: input['microphoneEnabled']! as bool,
        speakerEnabled: input['speakerEnabled']! as bool,
      );
}

class _SelfMemberEncoder extends Converter<SelfMember, Map<String, Object?>> {
  const _SelfMemberEncoder();

  @override
  Map<String, Object?> convert(SelfMember input) => {
        'id': input.id,
        'name': input.name,
        'videoEnabled': input.videoEnabled,
        'microphoneEnabled': input.microphoneEnabled,
        'speakerEnabled': input.speakerEnabled,
      };
}
