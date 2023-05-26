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
abstract class JcNativeApi {
  /// Logs the client in with the specified app account number and name.
  ///
  /// [appAccountNumber] is the app account number to log in with.
  ///
  /// [name] is the name to log in with.
  ///
  /// Returns `true` if the login was started successfully, `false` otherwise.
  bool login(String appAccountNumber, String name);

  /// Joins the specified conference.
  ///
  /// [conferenceID] is the ID of the conference to join.
  ///
  /// [password] is the password of the conference to join.
  ///
  /// Returns `true` if the conference was joined successfully, `false` otherwise.
  ///
  /// The client must be logged in before calling this method. See [login].
  bool joinConference(String conferenceID, String password);

  /// Initiates a call to the specified user.
  ///
  /// [userID] is the user ID of the user to call.
  ///
  /// [video] is whether the call should be a video call.
  ///
  /// Returns `true` if the call was initiated successfully, `false` otherwise.
  ///
  /// The client must be logged in before calling this method. See [login].
  bool call(String userID, bool video);
}
