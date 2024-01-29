//
//  CreateProfile.Req.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/29/24.
//

import UIKit

extension RequestDTO {
    struct CreateUserProfileDTO: Requestable {
        var deviceId = UIDevice.uuidString
        
        var name: String
        var birth: String
        var major: String
        var clubs: [String]
        var subwayStations: [String]
        var mbti: String
        
        init(query: CreateUserQuery) {
            self.name = query.name
            self.birth = query.birth
            self.major = query.major
            self.clubs = query.clubs
            self.subwayStations = query.subwayStationName
            self.mbti = query.mbti
        }
        
        var toDitionary: DictionaryType {
            [
                "name": name,
                "birthDate": birth,
                "age": 0,
                "jobGroup": major,
                "clubs": clubs,
                "subwayStations": subwayStations,
                "mbti": mbti,
                "deviceNumber": deviceId,
            ]
        }
    }
}
