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
        var major: String
        var clubs: [String]
        var bloodType: String
        var subwayStations: [String]
        var mbti: String
        
        init(query: CreateUserQuery) {
            self.name = query.name
            self.major = query.major
            self.clubs = query.clubs
            self.bloodType = query.bloodType
            self.subwayStations = query.subwayStationName
            self.mbti = query.mbti
        }
        
        var toDitionary: DictionaryType {
            [
                "name": name,
                "jobGroup": major,
                "clubs": clubs,
                "bloodType": bloodType,
                "subwayStations": subwayStations,
                "mbti": mbti,
                "deviceNumber": deviceId,
            ]
        }
    }
}
