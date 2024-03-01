//
//  UserDataStorage.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import SwiftUI

final class UserDefaultImplement: UserDefaultInject {
    static let shared: UserDefaultImplement = UserDefaultImplement()
    
    private init() {}

    /// 해당 사용자가 프로필이 존재하는지 유무
    @AppStorage(UserDefaultKeyCase.hasProfile.rawValue)
    var hasProfile: Bool = false
    
    /// 유저의 프로필
    @AppStorage(UserDefaultKeyCase.profiles.rawValue)
    var profiles: [Profile] = []
    
    /// 유저가 매칭한 결과물
    @AppStorage(UserDefaultKeyCase.matchedResults.rawValue)
    var matchedResults: [MatchingInfo] = []
    
    /// 빙고보드 딕셔너리
    /// - e.g ["istp": 4, "enfj": 1]
    var mbtiBoard: [String: Int] {
        get {
            UserDefaults.standard.dictionary(
                forKey: UserDefaultKeyCase.mbtiBoard.rawValue
            ) as? [String: Int] ?? [:]
        }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultKeyCase.mbtiBoard.rawValue) }
    }
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case hasProfile
    case profiles
    case matchedResults
    case mbtiBoard
}
