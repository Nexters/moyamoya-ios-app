//
//  ResponseDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

extension ResponseDTO {
    struct ProfileDTO: ResponseType {
        var status: Int
        var message: String
        let data: DataClass

        // MARK: - DataClass
        struct DataClass: Decodable {
            /// 멤버 id
            let id: String
            /// 멤버 이름
            let name: String
            /// 멤버 생년 월일 `yyyy-MM-dd`
            let birth: String
            /// 나이
            let age: Int
            /// 별자리
            let constellation: String
            /// 직군
            let jobGroup: String
            /// 동아리
            let clubs: [String]
            /// 지하철 역
            let subwayStations: [String]
            /// mbti
            let mbti: String
            /// 해당 유저 코드
            let memberCode: String
        }
    }
}

extension ResponseDTO.ProfileDTO {
    func toDomain() -> Profile {
        return Profile.testableValue
    }
}
//
//{
//  "status": "string",
//  "message": "string",
//  "data": {
//    "id": "string",
//    "name": "string",
//    "birth": "2024-01-28",
//    "age": 0,
//    "constellation": "string",
//    "jobGroup": "string",
//    "clubs": [
//      "string"
//    ],
//    "subwayStations": [
//      "string"
//    ],
//    "mbti": "string",
//    "memberCode": "string"
//  }
//}
