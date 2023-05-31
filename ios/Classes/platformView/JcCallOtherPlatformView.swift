//
//  JcCallOtherPlatformView.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Flutter
import UIKit
import Foundation
import JCSDKOC

class JcCallOtherPlatformViewFactory: NSObject, FlutterPlatformViewFactory {

    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return JcCallOtherPlatformView(frame: frame, viewId: viewId, messenger: messenger, args: args)
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class JcCallOtherPlatformView: NSObject, FlutterPlatformView, JcViewController {
    func view() -> UIView {
        return _view
    }
    
    private let viewId: Int64
    private let messenger: FlutterBinaryMessenger
    private var _view: UIView
    private var canvas: JCMediaDeviceVideoCanvas?

    init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any?) {
        self.viewId = viewId
        self.messenger = messenger

        // Creating the view
        _view = UIView()
        
        super.init()
        
        // Setup JcViewController
        JcViewControllerSetup.setUp(binaryMessenger: messenger, viewId: viewId, viewController: self)

        // Assuming 'canvas' is an accessible object and videoView is a UIView subclass
        canvas = JCRoom.shared.call.getActiveCallItem()?.startOtherVideo(
            .fullScreen
        )
        
        // Add the video view to 'view'
        _view.addSubview(canvas!.videoView)
        
    }
    
    func setLayoutParams(width: Double, height: Double) {
        canvas?.videoView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    // Dispose function
    func dispose() {
        canvas?.videoView.removeFromSuperview()
        JcViewControllerSetup.setUp(binaryMessenger: messenger, viewId: viewId, viewController: nil)
    }
}
