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
        var subwayStation: String
        var mbti: String
        
        init(query: CreateUserQuery) {
            self.name = query.name
            self.birth = query.birth
            self.major = query.major
            self.clubs = query.clubs
            self.subwayStation = query.subwayStation
            self.mbti = query.mbti
        }
        
        var toDitionary: DictionaryType {
            [
                "deviceId": deviceId,
                "name": name,
                "birth": birth,
                "major": major,
                "clubs": clubs,
                "subwayStation": subwayStation,
                "mbti": mbti
            ]
        }
    }
}

