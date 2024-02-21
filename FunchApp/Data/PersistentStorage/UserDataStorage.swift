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

    /// 유저의 프로필
    @AppStorage(UserDefaultKeyCase.profiles.rawValue)
    var profiles: [Profile] = []
    
    /// 유저가 매칭한 결과물
    @AppStorage(UserDefaultKeyCase.matchedResults.rawValue)
    var matchedResults: [MatchingInfo] = []
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case profiles
    case matchedResults
}
