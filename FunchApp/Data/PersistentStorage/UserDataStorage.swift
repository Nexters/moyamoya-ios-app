//
//  UserDataStorage.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import SwiftUI

final class UserDefaultStorage {
    
    static let shared: UserDefaultStorage = UserDefaultStorage()
    
    private init() {}

    /// 해당 사용자가 프로필이 존재하는지 유무
    @AppStorage(UserDefaultKeyCase.hasProfile.rawValue)
    var hasProfile: Bool = false
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case hasProfile
}
