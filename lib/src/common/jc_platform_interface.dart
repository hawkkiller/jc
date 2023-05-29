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

  /// Initializes the engine.
  ///
  /// Returns `true` if the engine was initialized successfully, `false` otherwise.
  Future<bool> initialize(String appKey);

  /// A stream of client states.
  Stream<ClientState> get clientStateStream;
}
