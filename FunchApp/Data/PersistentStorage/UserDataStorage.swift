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
    var profiles: Set<Profile> { get set }
    /// 매칭된 유저의 프로필 리스트
    var matchedResults: [MatchingInfo] { get set }
    /// mbti 보드의 결과
    var mbtiBoard: [String: Int] { get set }
    /// 멀티프로필 중 현재 선택한 프로필
    var selectionProfile: Profile? { get set }
}


final class UserDefaultImpl: UserStorage {
//    init() {
//        profiles = []
//    }
    
    /// 해당 사용자가 프로필이 존재하는지 유무
    var selectionProfile: Profile? {
        get {
            UserDefaults.standard.object(
                forKey: UserDefaultKeyCase.selectionProfile.rawValue
            ) as? Profile
        }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultKeyCase.selectionProfile.rawValue) }
    }
    
    /// 유저의 프로필
    @AppStorage(UserDefaultKeyCase.profiles.rawValue)
    var profiles: Set<Profile> = []
    
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
    case selectionProfile
    case profiles
    case matchedResults
    case mbtiBoard
}
