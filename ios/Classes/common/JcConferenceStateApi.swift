//
//  JcCallStateApi.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Foundation
import Flutter

protocol JcConferenceStateApi {
    func microphone() -> Bool
    
    func video() -> Bool
    
    func speaker() -> Bool
    
    func uid() -> String
    
    func members() -> [[String: Any]]
    
    func conferenceStatus() -> String
}

class JcConferenceStateApiSetup {
    
    static private var selfMemberSink: FlutterEventSink?
    static private var membersSink: FlutterEventSink?
    static private var conferenceStatusSink: FlutterEventSink?
    static private var stateApi: JcConferenceStateApi?
    
    private static func sendSelfMember() {
        guard let api = stateApi else { return }
        let map: [String: Any] = [
            "video": api.video(),
            "microphone": api.microphone(),
            "speaker": api.speaker(),
            "uid": api.uid(),
        ]
        selfMemberSink?(map)
    }

    private static func sendOtherMember() {
        guard let api = stateApi else { return }
        membersSink?(api.members())
    }

    private static func sendConferenceStatus() {
        guard let api = stateApi else { return }
        conferenceStatusSink?(api.conferenceStatus())
    }
    
    @objc static func handleNotification(_ notification: NSNotification) {
        sendSelfMember()
        sendOtherMember()
        sendConferenceStatus()
    }
    
    static func setUp(binaryMessenger: FlutterBinaryMessenger, stateApi: JcConferenceStateApi?) {
        let selfMemberChannel = FlutterEventChannel(name: "lazebny.io.jc/jc_conference_state_channel/self", binaryMessenger: binaryMessenger)
        let membersChannel = FlutterEventChannel(name: "lazebny.io.jc/jc_conference_state_channel/members", binaryMessenger: binaryMessenger)
        let conferenceStatusChannel = FlutterEventChannel(name: "lazebny.io.jc/jc_conference_state_channel/status", binaryMessenger: binaryMessenger)
        
        self.stateApi = stateApi
        if stateApi == nil {
            selfMemberChannel.setStreamHandler(nil)
            membersChannel.setStreamHandler(nil)
            conferenceStatusChannel.setStreamHandler(nil)
            NotificationCenter.default.removeObserver(self)
            return
        }
        
        selfMemberChannel.setStreamHandler(StreamHandler(onListen: { sink in
            selfMemberSink = sink
            sendSelfMember()
        }))
        
        membersChannel.setStreamHandler(StreamHandler(onListen: { sink in
            membersSink = sink
            sendOtherMember()
        }))
        
        conferenceStatusChannel.setStreamHandler(StreamHandler(onListen: { sink in
            conferenceStatusSink = sink
            sendConferenceStatus()
        }))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: mediaDeviceNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: mediaChannelNotification, object: nil)
    }
}
