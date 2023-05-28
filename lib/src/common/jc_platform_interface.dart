import 'package:jc/src/common/jc_controller.dart';
import 'package:jc/src/logic/shared_platform.dart';
import 'package:jc/src/model/client_state.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class JcPlatform extends PlatformInterface {
  /// Constructs a JcPlatform.
  JcPlatform() : super(token: _token);

  static final Object _token = Object();

  static JcPlatform _instance = SharedPlatform();

  /// The default instance of [JcPlatform] to use.
  ///
  /// Defaults to [SharedPlatform].
  static JcPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JcPlatform] when
  /// they register themselves.
  static set instance(JcPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Logs the client in with the specified app account number and name.
  ///
  /// [appAccountNumber] is the app account number to log in with.
  ///
  /// [name] is the name to log in with.
  ///
  /// Returns `true` if the login was started successfully, `false` otherwise.
  Future<bool> login(String appAccountNumber, String name);

  /// Joins the specified conference.
  ///
  /// [conferenceID] is the ID of the conference to join.
  ///
  /// [password] is the password of the conference to join.
  ///
  /// Returns `true` if the conference was joined successfully, `false` otherwise.
  ///
  /// The client must be logged in before calling this method. See [login].
  Future<ConferenceController> joinConference(String conferenceID, {String password = ''});

  /// Initiates a call to the specified user.
  ///
  /// [userID] is the user ID of the user to call.
  ///
  /// [video] is whether the call should be a video call.
  ///
  /// Returns [CallController] if the call was started successfully, throws [Exception] otherwise.
  ///
  /// The client must be logged in before calling this method. See [login].
  Future<CallController> call(String userID, {bool video = false});

  /// A stream of client states.
  Stream<ClientState> get clientStateStream;
}
