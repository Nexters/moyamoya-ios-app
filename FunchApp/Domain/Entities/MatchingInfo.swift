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
    var synergyInfo: SynergyInfo
    /// 추천정보
    var recommendInfo: RecommendInfo
    
    struct SynergyInfo {
        /// 제목
        var title: String
        /// 설명
        let description: Description
        
        struct Description {
            /// 전체 텍스트
            var text: String
            /// 강조하는 텍스트
            var highlightText: String
            /// 강조하는 텍스트 컬러 색상
            var highlightColor: String
            /// 강조하는 컬러 투명도
            var highlightColorOpacity: Float
        }
    }
    
    struct RecommendInfo {
        /// 추천 내용
        var title: String
    }
}
