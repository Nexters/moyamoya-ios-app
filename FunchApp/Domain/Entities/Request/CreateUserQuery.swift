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
    var subwayStationName: [String]
    /// mbti
    var mbti: String
    
    init(
        name: String,
        birth: String,
        major: String,
        clubs: [String],
        subwayStationName: [String],
        mbti: String
    ) {
        self.name = name
        self.birth = Self.formatDateString(birth)
        self.major = major
        self.clubs = clubs
        self.subwayStationName = subwayStationName
        self.mbti = mbti
    }
    
    /// 서버의 요청 포맷에 맞게 규격 수정
    static func formatDateString(_ inputString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        if let date = dateFormatter.date(from: inputString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        } else {
            return inputString
        }
    }
}
