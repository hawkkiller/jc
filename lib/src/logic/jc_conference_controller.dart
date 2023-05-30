import 'package:jc/src/common/controller.dart';
import 'package:jc/src/generated/messages.g.dart';
import 'package:jc/src/logic/jc_conference_state_channel.dart';
import 'package:jc/src/model/conference_status.dart';
import 'package:jc/src/model/member.dart';
import 'package:meta/meta.dart';

/// The base implementation of [ConferenceController] for conference calls.
base class JcConferenceController implements ConferenceController {
  JcConferenceController.create({
    @visibleForTesting JcConferenceControllerApi? jcConferenceControllerApi,
    @visibleForTesting JcConferenceStateChannel? jcConferenceStateChannel,
  })  : _jcConferenceControllerApi = jcConferenceControllerApi ?? JcConferenceControllerApi(),
        _jcConferenceStateChannel = jcConferenceStateChannel ?? JcConferenceStateChannelBase();

  final JcConferenceControllerApi _jcConferenceControllerApi;
  final JcConferenceStateChannel _jcConferenceStateChannel;

  @override
  Future<void> enableCamera({required bool value}) =>
      _jcConferenceControllerApi.enableCamera(value);

  @override
  Future<void> enableMicrophone({required bool value}) =>
      _jcConferenceControllerApi.enableMicrophone(value);

  @override
  Future<void> enableSpeaker({required bool value}) =>
      _jcConferenceControllerApi.enableSpeaker(value);

  @override
  Future<void> leave() => _jcConferenceControllerApi.leave();

  @override
  Stream<List<ConferenceMember>> get members => _jcConferenceStateChannel.members;

  @override
  Stream<ConferenceSelfMember> get selfMember => _jcConferenceStateChannel.selfMember;

  @override
  Future<void> switchCamera() => _jcConferenceControllerApi.switchCamera();

  @override
  Future<bool> joinConference(
    String conferenceID, {
    String password = '',
  }) async {
    final res = await _jcConferenceControllerApi.joinConference(conferenceID, password);
    if (res) {
      await status.firstWhere((status) => status != ConferenceStatus.off);
    }
    return res;
  }

  @override
  Stream<ConferenceStatus> get status => _jcConferenceStateChannel.status;
}
