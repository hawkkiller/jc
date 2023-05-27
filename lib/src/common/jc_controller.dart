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
  Stream<List<void>> get members;

  /// The stream of the self member in the conference.
  Stream<void> get selfMember;
}

/// The controller for a call.
abstract interface class CallController extends Controller {
  /// Terminates the call.
  Future<void> terminate();

  /// The stream of the other member in the call.
  Stream<void> get otherMember;

  /// The stream of the self member in the call.
  Stream<void> get selfMember;
}
