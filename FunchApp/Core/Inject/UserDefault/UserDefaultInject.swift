//
//  ApplicationUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import Foundation

protocol UserDefaultInject {
    /// 유저 프로필 리스트 (멀티 프로필 지원을 위함)
    var profiles: [Profile] { get set }
    /// 매칭된 유저의 프로필 리스트
    var matchedResults: [MatchingInfo] { get set }
    /// mbti 보드의 결과
    var mbtiBoard: [String: Int] { get set }
}
