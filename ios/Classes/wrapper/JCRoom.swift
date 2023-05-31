//
//  JCManager.swift
//  Room
//
//  Created by 沈世达 on 2019/11/1.
//  Copyright © 2019 沈世达. All rights reserved.
//

import UIKit
import JCSDKOC

@objcMembers
class JCRoom: NSObject {

    
    // 通过关键字 static 来保存实例引用
    private static let instance = JCRoom()

    public static var shared : JCRoom {
        return self.instance
    }

    private var _client : JCClient?
    private var _mediaDevice : JCMediaDevice?
    private var _mediaChannel : JCMediaChannel?
    private var _call : JCCall?
    
    var client: JCClient {
        get {
            return _client!
        }
    }
    
    var mediaDevice: JCMediaDevice {
        get {
            return _mediaDevice!
        }
    }
    
    var mediaChannel: JCMediaChannel {
        get {
            return _mediaChannel!
        }
    }
    
    var call: JCCall {
        get {
            return _call!
        }
    }
    
    public func initialize() -> Bool {
        let appkey: String = UserDefaults.standard.string(forKey: "kAppkey") ?? MY_APP_KEY
        let server: String = UserDefaults.standard.string(forKey: "kServer") ?? "http:cn.router.justalkcloud.com:8080"

        let client = JCClient.create(appkey, callback: self, createParam: nil)
        client?.serverAddress = server
        let mediaDevice = JCMediaDevice.create(client!, callback: self)
        mediaDevice!.setCameraProperty(1280, height:720, framerate:30)
        let mediaChannel = JCMediaChannel.create(client!, mediaDevice: mediaDevice!, callback: self)
        JCNet.shared()?.add(self)
        let jcCall = JCCall.create(client!, mediaDevice: mediaDevice!, callback: self)
        
        self._client = client
        self._mediaDevice = mediaDevice
        self._mediaChannel = mediaChannel
        self._call = jcCall
        
        UserDefaults.standard.setValue(appkey, forKey: "kAppkey")
        UserDefaults.standard.setValue(server, forKey: "kServer")
        UserDefaults.standard.synchronize()
        
        return client != nil && mediaDevice != nil && mediaChannel != nil
    }
    
    public func reInitialize(appkey: String, server: String) {
        let kAppkey = appkey.isEmpty ? MY_APP_KEY : appkey
        let kServer = server.isEmpty ? "http:cn.router.justalkcloud.com:8080" : server
        
        let client = JCClient.create(kAppkey, callback: self, createParam: nil)
        client?.serverAddress = kServer;
        let mediaDevice = JCMediaDevice.create(client!, callback: self)
        mediaDevice!.setCameraProperty(1280, height:720, framerate:30)
        let mediaChannel = JCMediaChannel.create(client!, mediaDevice: mediaDevice!, callback: self)
        JCNet.shared()?.add(self)
        let jcCall = JCCall.create(client!, mediaDevice: mediaDevice!, callback: self)
        
        
        self._client = client
        self._mediaDevice = mediaDevice
        self._mediaChannel = mediaChannel
        self._call = jcCall
        
        UserDefaults.standard.setValue(kAppkey, forKey: "kAppkey")
        UserDefaults.standard.setValue(kServer, forKey: "kServer")
        UserDefaults.standard.synchronize()
    }
}

let mediaChannelNotification = Notification.Name(rawValue: "mediaChannelNotification")
let mediaDeviceNotification = Notification.Name(rawValue: "mediaDeviceNotification")
let callNotification = Notification.Name(rawValue: "callNotification")
let clientNotification = Notification.Name(rawValue: "clientNotification")

extension JCRoom: JCCallCallback {
    func onCallItemAdd(_ item: JCCallItem) {
        NotificationCenter.default.post(name: callNotification, object: nil, userInfo: nil);
    }
    
    func onCallItemRemove(_ item: JCCallItem, reason: JCCallReason, description: String?) {
        NotificationCenter.default.post(name: callNotification, object: nil, userInfo: nil);
    }
    
    func onCallItemUpdate(_ item: JCCallItem, changeParam: JCCallChangeParam?) {
        NotificationCenter.default.post(name: callNotification, object: nil, userInfo: nil);
    }
    
    func onMessageReceive(_ item: JCCallItem, type: String, content: String) {
        
    }
    
    func onMissedCallItem(_ item: JCCallItem) {
        
    }
    
    func onDtmfReceived(_ item: JCCallItem, value: JCCallDtmf) {
        
    }
}

extension JCRoom: JCClientCallback {
    
    func onLogin(_ result: Bool, reason: JCClientReason) {
        NotificationCenter.default.post(name: clientNotification, object: nil, userInfo: nil);
    }

    func onLogout(_ reason: JCClientReason) {
        NotificationCenter.default.post(name: clientNotification, object: nil, userInfo: nil);
    }

    func onClientStateChange(_ state: JCClientState, oldState: JCClientState) {
        NotificationCenter.default.post(name: clientNotification, object: nil, userInfo: nil);
    }
    
    func onOnlineMessageReceive(_ userId: String!, content: String!) {
        
    }
    
    func onOnlineMessageSend(_ operationId: Int32, result: Bool) {
        
    }
}

extension JCRoom: JCMediaDeviceCallback {

    func onCameraUpdate() {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onAudioOutputTypeChange(_ audioOutputType: String!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onRenderReceived(_ canvas: JCMediaDeviceVideoCanvas!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onRenderStart(_ canvas: JCMediaDeviceVideoCanvas!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onAudioInerruptAndResume(_ interrupt: Bool) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }
}

extension JCRoom: JCMediaChannelCallback {

    func onParticipantVolumeChange(_ participant: JCMediaChannelParticipant!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }
    
    func onMediaChannelStateChange(_ state: JCMediaChannelState, oldState: JCMediaChannelState) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onMediaChannelPropertyChange(_ changeParam: JCMediaChannelPropChangeParam!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onJoin(_ result: Bool, reason: JCMediaChannelReason, channelId: String!) {
        if result {
//            self.mediaDevice.enableSpeaker(true)
            NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
        } else {
            NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
        }
    }

    func onLeave(_ reason: JCMediaChannelReason, channelId: String!) {
        if reason == .over {
            NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
        } else {
            NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
        }
    }

    func onStop(_ result: Bool, reason: JCMediaChannelReason) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onQuery(_ operationId: Int32, result: Bool, reason: JCMediaChannelReason, queryInfo: JCMediaChannelQueryInfo!) {

    }

    func onParticipantJoin(_ participant: JCMediaChannelParticipant!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: participant, userInfo: nil);
    }

    func onParticipantLeft(_ participant: JCMediaChannelParticipant!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: participant, userInfo: nil);
    }

    func onParticipantUpdate(_ participant: JCMediaChannelParticipant!, participantChangeParam: JCMediaChannelParticipantChangeParam!) {
        NotificationCenter.default.post(name: mediaDeviceNotification, object: nil, userInfo: nil);
    }

    func onMessageReceive(_ type: String!, content: String!, fromUserId: String!) {
    }

    func onInviteSipUserResult(_ operationId: Int32, result: Bool, reason: Int32) {

    }
}

extension JCRoom: JCNetCallback {
    func onNetChange(_ newNetType: JCNetType, oldNetType: JCNetType) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNetWorkNotification), object: nil, userInfo: nil);
    }
}
