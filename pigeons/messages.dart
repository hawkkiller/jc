// ignore_for_file: avoid_positional_boolean_parameters

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/generated/messages.g.dart',
    kotlinOut: 'android/src/main/kotlin/lazebny/io/jc/pigeon/Messages.g.kt',
    swiftOut: 'ios/Classes/Messages.g.swift',
  ),
)
@HostApi()
abstract class JcApi {
  /// Logs the client in with the specified app account number and name.
  ///
  /// [appAccountNumber] is the app account number to log in with.
  ///
  /// [name] is the name to log in with.
  ///
  /// Returns `true` if the login was started successfully, `false` otherwise.
  bool login(String appAccountNumber, String name);

  /// Initializes the engine.
  ///
  /// Returns `true` if the engine was initialized successfully, `false` otherwise.
  bool initialize(String appKey);
}

@HostApi()
abstract class JcCallControllerApi {
  /// Enables or disables the microphone.
  void enableMicrophone(bool value);

  /// Enables or disables the camera.
  void enableCamera(bool value);

  /// Enables or disables the speaker.
  void enableSpeaker(bool value);

  /// Switches the camera.
  void switchCamera();

  /// Terminates the call.
  void terminate();

  /// Initiates a call to the specified user.
  ///
  /// [userID] is the user ID of the user to call.
  ///
  /// [video] is whether the call should be a video call.
  ///
  /// Returns `true` if the call was initiated successfully, `false` otherwise.
  ///
  /// The client must be logged in before calling this method.
  bool call(String userID, bool video);
}

@HostApi()
abstract class JcConferenceControllerApi {
  /// Enables or disables the microphone.
  void enableMicrophone(bool value);

  /// Enables or disables the camera.
  void enableCamera(bool value);

  /// Enables or disables the speaker.
  void enableSpeaker(bool value);

  /// Switches the camera.
  void switchCamera();

  /// Leaves the conference.
  void leave();

  /// Joins the specified conference.
  ///
  /// [conferenceID] is the ID of the conference to join.
  ///
  /// [password] is the password of the conference to join.
  ///
  /// Returns `true` if the conference was joined successfully, `false` otherwise.
  ///
  /// The client must be logged in before calling this method.
  bool joinConference(String conferenceID, String password);
}
