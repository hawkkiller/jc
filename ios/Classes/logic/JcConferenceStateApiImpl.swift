//
//  JcConferenceStateApi.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Foundation
import JCSDKOC

class JcConferenceStateApiImpl : JcConferenceStateApi {
    func microphone() -> Bool {
        let audio = JCRoom.shared.mediaChannel.selfParticipant?.audio ?? false
        let audioStart = JCRoom.shared.mediaDevice.audioStart
        return audio && audioStart
    }
    
    func video() -> Bool {
        let video = JCRoom.shared.mediaChannel.selfParticipant?.video ?? false
        let cameraOpen = JCRoom.shared.mediaDevice.cameraOpen
        return video && cameraOpen
    }
    
    func uid() -> String {
        return JCRoom.shared.mediaChannel.selfParticipant?.userId ?? ""
    }
    
    func speaker() -> Bool {
        return JCRoom.shared.mediaDevice.isSpeakerOn()
    }
    
    func members() -> [[String : Any]] {
        let participants = JCRoom.shared.mediaChannel.participants
        if (participants.isEmpty) {
            return []
        }
        
        var participantsWithoutSelf = participants.compactMap({ ($0 as! JCMediaChannelParticipant) })
        if let selfParticipant = JCRoom.shared.mediaChannel.selfParticipant,
           let index = participantsWithoutSelf.firstIndex(where: { $0 == selfParticipant }) {
            participantsWithoutSelf.remove(at: index)
        }

        return participantsWithoutSelf.map { participant in
            [
                "uid": participant.userId!,
                "name": participant.displayName!,
                "microphone": participant.audio,
                "video": participant.video,
            ]
        }
    }
    
    func conferenceStatus() -> String {
        let participants = JCRoom.shared.mediaChannel.participants
        if (participants.isEmpty) {
            return "off"
        }
        
        if (participants.count == 1) {
            return "waiting"
        }
        
        return "on"
    }
    
    
}
