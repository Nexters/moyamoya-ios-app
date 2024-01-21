//
//  ProfileQuery.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

struct CreateUserQuery {
    /// 이름
    var name: String
    /// 날짜
    var birth: String
    /// 전공
    var major: String
    /// 동아리
    var clubs: [String]
    /// 지하철역
    var subwayStation: String
    /// mbti
    var mbti: String
}
