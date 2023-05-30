//
//  JcCallStateApiImpl.swift
//  jc
//
//  Created by Михаил on 30.05.2023.
//

import Foundation
import JCSDKOC

class JcCallStateApiImpl : JcCallStateApi {
    private var stateOK: Bool {
        let state = JCRoom.shared.call.getActiveCallItem()?.state
        return state == .ok || state == .talking
    }
    
    func microphone() -> Bool {
        let micMute = JCRoom.shared.call.getActiveCallItem()?.microphoneMute ?? true
        let audioStarted = JCRoom.shared.mediaDevice.audioStart
        return audioStarted && !micMute
    }
    
    func video() -> Bool {
        let uploadVideo = JCRoom.shared.call.getActiveCallItem()?.uploadVideoStreamSelf ?? false
        let cameraOpen = JCRoom.shared.mediaDevice.cameraOpen
        return uploadVideo && cameraOpen
    }
    
    func speaker() -> Bool {
        return JCRoom.shared.mediaDevice.isSpeakerOn()
    }
    
    func otherMicrophone() -> Bool {
        let audioInterrupt = JCRoom.shared.call.getActiveCallItem()?.otherAudioInterrupt ?? true
        
        return stateOK && !audioInterrupt
    }
    
    func otherVideo() -> Bool {
        let video = JCRoom.shared.call.getActiveCallItem()?.uploadVideoStreamOther ?? false
        return stateOK && video
    }
    
    func callStatus() -> String {
        let call = JCRoom.shared.call
        guard let activeCall = call.getActiveCallItem() else { return "off" }
        switch activeCall.state {
        case .ok, .talking:
            return "on"
        case .pending, .connecting, .`init`:
            return "waiting"
        default:
            return "off"
        }
    }
    
    
}
