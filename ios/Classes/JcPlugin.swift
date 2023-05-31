import Flutter
import UIKit

public class JcPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let jcApi = JcApiImpl()
    let jcCallStateApi = JcCallStateApiImpl()
    let jcCallControllerApi = JcCallControllerApiImpl()

    JcApiSetup.setUp(binaryMessenger: registrar.messenger(), api: jcApi)
    JcCallControllerApiSetup.setUp(binaryMessenger: registrar.messenger(), api: jcCallControllerApi)
    JcCallStateApiSetup.setUp(binaryMessenger: registrar.messenger(), stateApi: jcCallStateApi)
    registrar.register(JcCallSelfPlatformViewFactory(messenger: registrar.messenger()), withId: "JcCallSelfView")
    registrar.register(JcCallOtherPlatformViewFactory(messenger: registrar.messenger()), withId: "JcCallOtherSelfView")
  }
}
