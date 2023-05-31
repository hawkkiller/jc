//
//  StreamHandler.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Foundation
import Flutter

class StreamHandler: NSObject, FlutterStreamHandler {
    private let onListen: (FlutterEventSink?) -> Void
    init(onListen: @escaping (FlutterEventSink?) -> Void) {
        self.onListen = onListen
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        onListen(events)
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        onListen(nil)
        return nil
    }
}
