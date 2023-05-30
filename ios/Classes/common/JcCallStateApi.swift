//
//  JcCallStateApi.swift
//  jc
//
//  Created by Михаил on 30.05.2023.
//

import Foundation
import Flutter

protocol JcCallStateApi {
    func microphone() -> Bool
    
    func video() -> Bool
    
    func speaker() -> Bool
    
    func otherMicrophone() -> Bool
    
    func otherVideo() -> Bool
    
    func callStatus() -> String
}

class JcCallStateApiSetup {
    
    static private var selfMemberSink: FlutterEventSink?
    static private var otherMemberSink: FlutterEventSink?
    static private var callStatusSink: FlutterEventSink?
    static private var stateApi: JcCallStateApi?
    
    private static func sendSelfMember() {
        guard let api = stateApi else { return }
        let map: [String: Any] = [
            "video": api.video(),
            "microphone": api.microphone(),
            "speaker": api.speaker()
        ]
        selfMemberSink?(map)
    }

    private static func sendOtherMember() {
        guard let api = stateApi else { return }
        let map: [String: Any] = [
            "video": api.otherVideo(),
            "microphone": api.otherMicrophone()
        ]
        otherMemberSink?(map)
    }

    private static func sendCallStatus() {
        guard let api = stateApi else { return }
        callStatusSink?(api.callStatus())
    }
    
    static func onEvent() {
        sendSelfMember()
        sendOtherMember()
        sendCallStatus()
    }
    
    static func setUp(binaryMessenger: FlutterBinaryMessenger, stateApi: JcCallStateApi?) {
        let selfMemberChannel = FlutterEventChannel(name: "lazebny.io.jc/jc_call_state_channel/self", binaryMessenger: binaryMessenger)
        let otherMemberChannel = FlutterEventChannel(name: "lazebny.io.jc/jc_call_state_channel/other", binaryMessenger: binaryMessenger)
        let callStatusChannel = FlutterEventChannel(name: "lazebny.io.jc/jc_call_state_channel/status", binaryMessenger: binaryMessenger)
        
        self.stateApi = stateApi
        if stateApi == nil {
            selfMemberChannel.setStreamHandler(nil)
            otherMemberChannel.setStreamHandler(nil)
            callStatusChannel.setStreamHandler(nil)
            return
        }
        
        selfMemberChannel.setStreamHandler(StreamHandler(onListen: { sink in
            selfMemberSink = sink
            sendSelfMember()
        }))
        
        otherMemberChannel.setStreamHandler(StreamHandler(onListen: { sink in
            otherMemberSink = sink
            sendOtherMember()
        }))
        
        callStatusChannel.setStreamHandler(StreamHandler(onListen: { sink in
            callStatusSink = sink
            sendCallStatus()
        }))
    }
}

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
