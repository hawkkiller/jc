//
//  JcCallSelfPlatformView.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Flutter
import UIKit
import Foundation
import JCSDKOC

class JcCallSelfPlatformViewFactory: NSObject, FlutterPlatformViewFactory {

    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return JcCallSelfPlatformView(frame: frame, viewId: viewId, messenger: messenger, args: args)
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class JcCallSelfPlatformView: NSObject, FlutterPlatformView, JcViewController {
    func view() -> UIView {
        return _view
    }
    
    private let frame: CGRect
    private let viewId: Int64
    private let messenger: FlutterBinaryMessenger
    private var _view: UIView

    init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.messenger = messenger

        // Creating the view
        _view = UIView(frame: frame)

        // Assuming 'canvas' is an accessible object and videoView is a UIView subclass
        let canvas = JCRoom.shared.call.getActiveCallItem()?.startSelfVideo(
            .fullScreen
        )

        // If 'canvas.videoView' is already added in a view, remove it
        canvas?.videoView.removeFromSuperview()
        
        if (canvas?.videoView != nil) {
            // Add the video view to 'view'
            _view.addSubview(canvas!.videoView)
        }
        super.init()

        // Setup JcViewController
        JcViewControllerSetup.setUp(binaryMessenger: messenger, viewId: viewId, viewController: self)
    }
    
    func setLayoutParams(width: Double, height: Double) {
        _view.frame.size.width = CGFloat(width)
        _view.frame.size.height = CGFloat(height)
    }
    
    // Dispose function
    func dispose() {
        _view.removeFromSuperview()
        JcViewControllerSetup.setUp(binaryMessenger: messenger, viewId: viewId, viewController: nil)
    }
}
