//
//  MatchingInfo.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/22/24.
//

import Foundation

struct MatchingInfo {
    /// 매칭된 유저의 프로필 정보
    var profile: Profile
    /// 매칭된 유저와 나의 닮은 정도
    var similarity: Int
    /// 시너지 정보
    var synergyInfos: [SynergyInfo]
    /// 추천정보
    var recommendInfos: [RecommendInfo]
    /// 지하철 정보
    var subwayInfos: [SubwayInfo]
    
    /// 궁합 정보
    struct SynergyInfo {
        /// 제목
        var title: String
        /// 설명
        var description: String
    }
    
    /// 추천 정보
    struct RecommendInfo {
        /// 추천 내용
        var title: String
    }
}
