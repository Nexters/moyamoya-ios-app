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
    
    /// 유저의 프로필
    @AppStorage(UserDefaultKeyCase.profiles.rawValue)
    var profiles: [Profile] = [.testableValue]
    
    /// 유저가 매칭한 결과물
    @AppStorage(UserDefaultKeyCase.matchedResults.rawValue)
    var matchedResults: [MatchingInfo] = [.testableValue]
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case hasProfile
    case profiles
    case matchedResults
}
