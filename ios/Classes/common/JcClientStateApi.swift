//
//  JcClientStateApi.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Foundation
import Flutter

protocol JcClientStateApi {
    func getClientState() -> Int
}

class JcClientStateApiSetup {
    
    static private var clientStateSink: FlutterEventSink?
    static private var clientStateApi: JcClientStateApi?
    
    static private func sendClientState() {
        if let state = clientStateApi?.getClientState() {
            clientStateSink?(state)
        }
    }
    
    @objc static func handleNotification(_ notification: NSNotification) {
        sendClientState()
    }
    
    static func setUp(messenger: FlutterBinaryMessenger, api: JcClientStateApi?) {
        let eventChannel = FlutterEventChannel(name: "lazebny.io.jc/client_state_event_channel", binaryMessenger: messenger)
        if (api == nil) {
            eventChannel.setStreamHandler(nil)
            NotificationCenter.default.removeObserver(self)
            return
        }
        eventChannel.setStreamHandler(StreamHandler { events in
            clientStateSink = events
            sendClientState()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: clientNotification, object: nil)
    }
}
