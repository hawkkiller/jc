import 'package:jc/src/model/call_status.dart';
import 'package:jc/src/model/conference_status.dart';
import 'package:jc/src/model/member.dart';

/// The base class for all controllers.
abstract interface class Controller {
  /// Enables or disables the microphone.
  ///
  /// [value] is whether the microphone should be enabled.
  Future<void> enableMicrophone({required bool value});

  /// Enables or disables the camera.
  ///
  /// [value] is whether the camera should be enabled.
  Future<void> enableCamera({required bool value});

  /// Enables or disables the speaker.
  ///
  /// [value] is whether the speaker should be enabled.
  Future<void> enableSpeaker({required bool value});

  /// Switches the camera.
  ///
  /// The default state of the camera is the front camera.
  Future<void> switchCamera();
}

/// The controller for a call.
abstract interface class ConferenceController extends Controller {
  /// Leaves the conference.
  Future<void> leave();

  /// The stream of the other members in the conference.
  Stream<List<ConferenceMember>> get members;

  /// The stream of the self member in the conference.
  Stream<ConferenceSelfMember> get selfMember;

  /// The stream of conference status changes.
  ///
  /// The status is [ConferenceStatus.off] when the conference is not joined.
  ///
  /// The status is [ConferenceStatus.on] when the conference is joined.
  ///
  /// The status is [ConferenceStatus.waiting] when the conference is joined but waiting for other members.
  Stream<ConferenceStatus> get status;

  Future<bool> joinConference(
    String conferenceID, {
    String password = '',
  });
}

/// The controller for a call.
///
/// Only one call can be active at a time.
abstract interface class CallController extends Controller {
  /// Terminates the call.
  Future<void> terminate();

  /// The stream of the other member in the call.
  Stream<Member> get otherMember;

  /// The stream of the self member in the call.
  Stream<SelfMember> get selfMember;

  /// The stream of call status changes.
  Stream<CallStatus> get status;

  /// Starts the call.
  Future<bool> call(String userID, {required bool video});
}
