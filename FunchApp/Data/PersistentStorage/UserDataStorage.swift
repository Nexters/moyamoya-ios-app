//
//  UserDataStorage.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import SwiftUI

protocol UserStorage {
    /// 유저 프로필 리스트 (멀티 프로필 지원을 위함)
    var profiles: [Profile] { get set }
    /// 매칭된 유저의 프로필 리스트
    var matchedResults: [MatchingInfo] { get set }
    /// mbti 보드의 결과
    var mbtiBoard: [String: Int] { get set }
}


final class UserDefaultImpl: UserStorage {
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
