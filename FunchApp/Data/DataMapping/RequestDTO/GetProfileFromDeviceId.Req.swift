//
//  GetProfileFromDeviceId.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/29/24.
//

import Foundation

extension RequestDTO {
    /// 디바이스 아이디로 프로필을 조회
    struct GetProfileFromDeviceId: Requestable {
        var deviceId: String
        
        init(deviceId: String) {
            self.deviceId = deviceId
        }
        
        var toDitionary: DictionaryType {
            [
                "deviceNumber": deviceId,
            ]
        }
    }
}
