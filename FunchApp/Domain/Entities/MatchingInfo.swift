//
//  MatchingInfo.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/22/24.
//

import Foundation

struct MatchingInfo: Identifiable, Equatable {
    static func == (lhs: MatchingInfo, rhs: MatchingInfo) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    
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
    struct MatchProfile: Codable {
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
    
    struct ChemistryInfo: Hashable, Codable {
        let title: String
        let description: String
    }
    
    /// 추천 정보
    struct RecommendInfo: Codable {
        /// 추천 내용
        var title: String
    }
}

extension MatchingInfo: Codable {}

extension MatchingInfo {
    static var testableValue: MatchingInfo {
        return MatchingInfo(
            profile: .init(name: "이성민",
                           major: Profile.Major.dummies[0].name,
                           clubs: Profile.Club.dummies.map { $0.name },
                           mbti: "ENTJ",
                           bloodType: "A",
                           subwayNames: ["고속터미널"]),
            similarity: 80,
            chemistryInfos: [.init(title: "찾았다, 내 소울메이트!", description: "ENTJ인 이성민님은 비전을 향해 적극적으로 이끄는 리더 타입!"),
                           .init(title: "서로 다른 점을 찾는 재미", description: "A형인 이성민님은 호기심과 창의력을 갖췄지만 변덕스러워요"),
                           .init(title: "7호선에서 만나요", description: "이성민님도 7호선에 살고 있어요")],
            recommendInfos: [.init(title: "")],
            subwayInfos: [.init(name: "상도역", lines: ["7"])]
        )
    }
}

extension MatchingInfo {
    static var empty: MatchingInfo {
        .init(profile: .empty, 
              similarity: 0,
              chemistryInfos: [],
              recommendInfos: [],
              subwayInfos: [])
    }
}

extension MatchingInfo.MatchProfile {
    static var empty: MatchingInfo.MatchProfile {
        .init(name: "", major: "", clubs: [], mbti: "", bloodType: "", subwayNames: [])
    }
}
