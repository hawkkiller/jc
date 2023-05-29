import 'package:jc/src/common/jc_controller.dart';
import 'package:jc/src/generated/messages.g.dart';
import 'package:jc/src/logic/jc_conference_state_channel.dart';
import 'package:jc/src/model/member.dart';
import 'package:meta/meta.dart';

/// The base implementation of [ConferenceController] for conference calls.
base class JcConferenceController implements ConferenceController {
  JcConferenceController._({
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
  Stream<List<Member>> get members => _jcConferenceStateChannel.members;

  @override
  Stream<SelfMember> get selfMember => _jcConferenceStateChannel.selfMember;

  @override
  Future<void> switchCamera() => _jcConferenceControllerApi.switchCamera();

  @override
  Future<bool> joinConference(
    String conferenceID, {
    String password = '',
  }) =>
      _jcConferenceControllerApi.joinConference(conferenceID, password);

  // /// Creates a new [JcConferenceController].
  // ///
  // /// Joins the conference with [conferenceID].
  // ///
  // /// [conferenceID] is the user ID to call.
  // ///
  // /// [password] is the password to use for the conference (omit for non-protected rooms).
  // ///
  // /// [jcConferenceApi] is the API to use for the call. This is only used for testing.
  // ///
  // /// Throws a [JcException] if the call could not be initiated.
  // static Future<JcConferenceController> create({
  //   required String conferenceID,
  //   String password='',
  //   @visibleForTesting JcConferenceApi? jcConferenceApi,
  // }) async {
  //   try {
  //     final api = jcConferenceApi ?? JcConferenceApi();
  //     final joinedConference = await api.joinConference(conferenceID, password);
  //     if (!joinedConference) {
  //       throw PlatformException(code: 'initiateCallFailed');
  //     }
  //   } on PlatformException catch (e, stackTrace) {
  //     Error.throwWithStackTrace(JcPlatformException(e), stackTrace);
  //   }
  //   return JcConferenceController._();
  // }
}
