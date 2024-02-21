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

    /// 해당 디바이스에서 몇번의 아이디가 생성되었는지 여부 (delete api 없어서 임시)
    @AppStorage(UserDefaultKeyCase.profileMakeCount.rawValue)
    var profileMakeCount: Int = 1
    
    /// 유저의 프로필
    @AppStorage(UserDefaultKeyCase.profiles.rawValue)
    var profiles: [Profile] = []
    
    /// 유저가 매칭한 결과물
    @AppStorage(UserDefaultKeyCase.matchedResults.rawValue)
    var matchedResults: [MatchingInfo] = []
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case profileMakeCount
    case profiles
    case matchedResults
}
