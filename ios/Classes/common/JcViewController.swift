//
//  JcViewController.swift
//  jc
//
//  Created by Михаил on 30.05.2023.
//

import Foundation
import Flutter

protocol JcViewController {
    func setLayoutParams(width: Double, height: Double)
}

class JcViewControllerSetup {
    static func setUp(binaryMessenger: FlutterBinaryMessenger, viewId: Int64, viewController: JcViewController?) {
        let methodChannel = FlutterMethodChannel(name: "lazebny.io.jc/JcViewController/\(viewId)",
                                                 binaryMessenger: binaryMessenger)

        if viewController == nil {
            methodChannel.setMethodCallHandler(nil)
            return
        }

        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "setLayoutParams":
                if let args = call.arguments as? [String: Double],
                   let width = args["width"],
                   let height = args["height"] {
                    viewController?.setLayoutParams(width: width, height: height)
                    result(nil)
                } else {
                    result(FlutterError(code: "Invalid args", message: "Width or height was not a Double", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
