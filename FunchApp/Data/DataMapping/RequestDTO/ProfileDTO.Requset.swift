//
//  ProfileDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import UIKit

extension RequestDTO {
    struct CreateUserProfileDTO: RequestType {
        var deviceId = UIDevice.uuidString
        
        var name: String
        var birth: String
        var major: String
        var clubs: [String]
        var subwayStation: [String]
        var mbti: String
        
        init(query: CreateUserQuery) {
            self.name = query.name
            self.birth = query.birth
            self.major = query.major
            self.clubs = query.clubs
            self.subwayStation = query.subwayStationName
            self.mbti = query.mbti
        }
        
        var toDitionary: DictionaryType {
            [
                "name": name,
                "birthDate": birth,
                "age": 0,
                "jobGroup": major,
                "clubs": clubs,
                "subwayStations": subwayStation,
                "mbti": mbti,
                "deviceNumber": deviceId,
            ]
        }
    }
}

//{
//  "name": "string",
//  "birthDate": "2024-01-28",
//  "age": 0,
//  "jobGroup": "string",
//  "clubs": [
//    "string"
//  ],
//  "subwayStations": [
//    "string"
//  ],
//  "mbti": "string",
//  "deviceNumber": "string"
//}
