//
//  JcApiImpl.swift
//  jc
//
//  Created by Михаил on 30.05.2023.
//

import Foundation
import JCSDKOC

class JcApiImpl : JcApi {
    func login(appAccountNumber: String, name: String) throws -> Bool {
        JCRoom.shared.client.displayName = name
        let loginParam = JCClientLoginParam()
        return JCRoom.shared.client.login(appAccountNumber, password: "123", loginParam: loginParam)
    }
    
    func initialize(appKey: String) throws -> Bool {
        MY_APP_KEY = appKey
        let inited = JCRoom.shared.initialize()
        if (!inited) {
            return false
        }
        
        JCRoom.shared.mediaDevice.audioParam.autoStartAudioOutputDevice = true
        JCRoom.shared.mediaDevice.audioParam.autoStartAudioInputDevice = true
        
        return true
    }
}
