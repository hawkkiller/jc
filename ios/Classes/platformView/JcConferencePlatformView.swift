import Flutter
import JCSDKOC

class JcConferencePlatformViewFactory: NSObject, FlutterPlatformViewFactory {
    let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let argsMap = args as! [String: Any]
        let uid = argsMap["uid"] as! String
        return JcConferencePlatformView(messenger: messenger, viewId: viewId, uid: uid)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class JcConferencePlatformView: NSObject, FlutterPlatformView, JcViewController {
    let _view: UIView
    let viewId: Int64
    let messenger: FlutterBinaryMessenger
    let uid: String
    private var canvas: JCMediaDeviceVideoCanvas?
    
    init(messenger: FlutterBinaryMessenger, viewId: Int64, uid: String) {
        self.messenger = messenger
        self.viewId = viewId
        self.uid = uid
        self._view = UIView()
        super.init()
        
        let participant = JCRoom.shared.mediaChannel.participants.compactMap({ ($0 as! JCMediaChannelParticipant) }).first { $0.userId == uid }
        canvas = participant?.startVideo(.fullScreen, pictureSize: .large)
        
        if let videoView = canvas?.videoView {
            _view.addSubview(videoView)
        }
        
        JcViewControllerSetup.setUp(binaryMessenger: messenger, viewId: viewId, viewController: self)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func dispose() {
        canvas?.videoView.removeFromSuperview()
        JcViewControllerSetup.setUp(binaryMessenger: messenger, viewId: viewId, viewController: nil)
    }
    
    func setLayoutParams(width: Double, height: Double) {
        canvas?.videoView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
}
