//
//  JcClientStateApiImpl.swift
//  jc
//
//  Created by Михаил on 31.05.2023.
//

import Foundation

class JcClientStateApiImpl : JcClientStateApi {
    func getClientState() -> Int {
        return JCRoom.shared.client.state.rawValue
    }
}
