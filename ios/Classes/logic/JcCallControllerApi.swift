//
//  JcCallControllerApi.swift
//  jc
//
//  Created by Михаил on 30.05.2023.
//

import JCSDKOC
import Foundation

class JcCallControllerApiImpl : JcCallControllerApi {
    func enableMicrophone(value: Bool) throws {
        let activeItem = JCRoom.shared.call.getActiveCallItem()
        if (activeItem == nil) {
            return
        }
        let res = JCRoom.shared.call.muteMicrophone(activeItem!, mute: !value)
        NSLog("enableMicrophone \(res)")
    }
    
    func enableCamera(value: Bool) throws {
        if (value) {
            JCRoom.shared.mediaDevice.startCamera()
        } else {
            JCRoom.shared.mediaDevice.stopCamera()
        }
    }
    
    func enableSpeaker(value: Bool) throws {
        JCRoom.shared.mediaDevice.enableSpeaker(value)
    }
    
    func switchCamera() throws {
        JCRoom.shared.mediaDevice.switchCamera()
    }
    
    func terminate() throws {
        let activeItem = JCRoom.shared.call.getActiveCallItem()
        if (activeItem == nil) {
            return
        }
        JCRoom.shared.call.term(activeItem!, reason: .none, description: nil)
    }
    
    func call(userID: String, video: Bool) throws -> Bool {
        let result = JCRoom.shared.call.call(
            userID,
            video: video,
            callParam: JCCallParam(extraParam: video ? "video" : "audio", ticket: "ticket")
        )
        if (result) {
            JCRoom.shared.mediaDevice.startAudio()
        }
        return result
    }
    
    
}
