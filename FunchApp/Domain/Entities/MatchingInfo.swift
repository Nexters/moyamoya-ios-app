//
//  MatchingInfo.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/22/24.
//

import Foundation

struct MatchingInfo {
    /// 매칭된 유저의 프로필 정보
    var profile: MatchProfile
    /// 매칭된 유저와 나의 닮은 정도
    var similarity: Int
    /// 시너지 정보
    var chemistryInfos: [ChemistryInfo]
    /// 추천정보
    var recommendInfos: [RecommendInfo]
    /// 지하철 정보
    var subwayInfos: [SubwayInfo]
    
    /// 매칭된 상대 프로필
    struct MatchProfile {
        /// 이름
        let name: String
        /// 전공
        let major: String
        /// 동아리
        let clubs: [String]
        /// mbti
        let mbti: String
        /// 혈액형
        let bloodType: String
        /// 지하철 정보
        let subwayNames: [String]
    }
    
    /// 궁합 정보
    struct ChemistryInfo {
        let title: String
        let description: String
    }
    
    /// 추천 정보
    struct RecommendInfo {
        /// 추천 내용
        var title: String
    }
}
