//
//  FetchUserQuery.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/3/24.
//

import UIKit

struct FetchUserQuery {
    
    /// 디바이스 아이디
    let deviceId = UIDevice.uuidString
    
    init() {}
    
    var toDitionary: DictionaryType {
        [
            "deviceNumber": deviceId,
        ]
    }
}
