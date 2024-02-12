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
    struct SynergyInfo: Hashable {
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

extension MatchingInfo {
    static var testableValue: MatchingInfo {
        return MatchingInfo(
            profile: .init(userCode: "ABCD",
                           userNickname: "이성민",
                           birth: "2000.02.21",
                           majors: Profile.Major.dummies,
                           clubs: Profile.Club.dummies,
                           mbti: "ENTJ",
                           bloodType: "A",
                           subwayInfos: [.testableValue],
                           viewerShip: "0"), 
            similarity: 80,
            synergyInfos: [.init(title: "찾았다, 내 소울메이트!", description: "ENTJ인 이성민님은 비전을 향해 적극적으로 이끄는 리더 타입!"),
                           .init(title: "서로 다른 점을 찾는 재미", description: "A형인 이성민님은 호기심과 창의력을 갖췄지만 변덕스러워요"),
                           .init(title: "7호선에서 만나요", description: "이성민님도 7호선에 살고 있어요")],
            recommendInfos: [.init(title: "")],
            subwayInfos: [.init(name: "상도역", lines: ["7"])]
        )
    }
}
