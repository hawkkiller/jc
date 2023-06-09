import 'package:jc/jc.dart';

class JcSdk {
  JcSdk._();

  static JcSdk get instance => _instance;

  static final JcSdk _instance = JcSdk._();

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

  /// Initializes the SDK.
  ///
  /// Returns `true` if the SDK was initialized successfully, `false` otherwise.
  Future<bool> initialize(String appKey) => _platform.initialize(appKey);

  /// A stream of client states.
  Stream<ClientState> get clientStateStream => _platform.clientStateStream;
}
