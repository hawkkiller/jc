//
//  JCRoomUtils.swift
//  JuphoonRoom
//
//  Created by 沈世达 on 2019/11/5.
//  Copyright © 2019 沈世达. All rights reserved.
//

import UIKit

class JCRoomUtils: NSObject {
    //验证手机号
    static func isPhoneNumber(phoneNumber:String) -> Bool {
        if phoneNumber.count == 0 {
            return false
        }
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        return regexMobile.evaluate(with: phoneNumber)
    }
}

