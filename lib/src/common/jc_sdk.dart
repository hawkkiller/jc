import 'package:jc/jc.dart';
import 'package:jc/src/common/jc_controller.dart';
import 'package:jc/src/model/client_state.dart';

class JcSdk {
  static JcPlatform get _platform => JcPlatform.instance;

  /// Logs the client in with the specified app account number and name.
  ///
  /// [appAccountNumber] is the app account number to log in with.
  ///
  /// [name] is the name to log in with.
  ///
  /// Returns `true` if the login was started successfully, `false` otherwise.
  ///
  /// The sdk must be initialized before calling this method. See [initialize].
  Future<bool> login({
    required String appAccountNumber,
    required String name,
  }) =>
      _platform.login(appAccountNumber, name);

  /// Initiates a call to the specified user.
  ///
  /// [userID] is the user ID of the user to call.
  ///
  /// [video] is whether the call should be a video call.
  ///
  /// Returns `true` if the call was initiated successfully, `false` otherwise.
  ///
  /// The client must be logged in before calling this method. See [login].
  Future<CallController> call({
    required String userID,
    required bool video,
  }) =>
      _platform.call(userID, video: video);

  /// Joins the specified conference.
  ///
  /// [conferenceID] is the ID of the conference to join.
  ///
  /// [password] is the password of the conference to join.
  ///
  /// Returns `true` if the conference was joined successfully, `false` otherwise.
  ///
  /// The client must be logged in before calling this method. See [login].
  Future<ConferenceController> joinConference({
    required String conferenceID,
    String password = '',
  }) =>
      _platform.joinConference(conferenceID, password: password);

  /// Initializes the SDK.
  ///
  /// Returns `true` if the SDK was initialized successfully, `false` otherwise.
  Future<bool> initialize() => _platform.initialize();

  /// A stream of client states.
  Stream<ClientState> get clientStateStream => _platform.clientStateStream;
}
