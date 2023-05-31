import Flutter
import UIKit

public class JcPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let jcApi = JcApiImpl()
    let jcCallStateApi = JcCallStateApiImpl()
    let jcCallControllerApi = JcCallControllerApiImpl()
    
    let jcConferenceStateApi = JcConferenceStateApiImpl()
    let jcConferenceControllerApi = JcConferenceControllerApiImpl()

    JcApiSetup.setUp(binaryMessenger: registrar.messenger(), api: jcApi)
    JcCallControllerApiSetup.setUp(binaryMessenger: registrar.messenger(), api: jcCallControllerApi)
    JcCallStateApiSetup.setUp(binaryMessenger: registrar.messenger(), stateApi: jcCallStateApi)
      
    JcConferenceControllerApiSetup.setUp(binaryMessenger: registrar.messenger(), api: jcConferenceControllerApi)
    JcConferenceStateApiSetup.setUp(binaryMessenger: registrar.messenger(), stateApi: jcConferenceStateApi)
    registrar.register(JcCallSelfPlatformViewFactory(messenger: registrar.messenger()), withId: "JcCallSelfView")
    registrar.register(JcCallOtherPlatformViewFactory(messenger: registrar.messenger()), withId: "JcCallOtherView")
      registrar.register(JcConferencePlatformViewFactory(messenger: registrar.messenger()), withId: "JcConferenceView")
  }
}
