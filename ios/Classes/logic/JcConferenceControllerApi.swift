//
//  JcConferenceControllerApi.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Foundation
import JCSDKOC

class JcConferenceControllerApiImpl : JcConferenceControllerApi {
    func enableMicrophone(value: Bool) throws {
        JCRoom.shared.mediaChannel.enableUploadAudioStream(value)
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
    
    func leave() throws {
        JCRoom.shared.mediaChannel.leave()
    }
    
    func joinConference(conferenceID: String, password: String) throws -> Bool {
        let joinParam = JCMediaChannelJoinParam()
        joinParam.password = password
        
        return JCRoom.shared.mediaChannel.join(conferenceID, joinParam: joinParam)
    }
}
