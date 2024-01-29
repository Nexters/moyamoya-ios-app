//
//  ProfileDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
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

extension ResponseDTO {
    struct CreateProfileDTO: Respondable {
        var status: Int
        var message: String
        
        var userCode: String
        var name: String
        var birth: String
        var age: Int
        var constellation: String
        var major: String
        var clubs: [String]
        var subwayStations: [String]
        var mbti: String
        
        enum CodingKeys: String, CodingKey {
            case status
            case message
            case userCode = "id"
            case name
            case birth = "birthDate"
            case age
            case constellation
            case major = "jobGroup"
            case clubs
            case subwayStations = "subwayStations"
            case mbti
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.CreateProfileDTO.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.CreateProfileDTO.CodingKeys.self)
            self.status = try container.decode(Int.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.message)
            self.userCode = try container.decode(String.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.userCode)
            self.name = try container.decode(String.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.name)
            self.birth = try container.decode(String.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.birth)
            self.age = try container.decode(Int.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.age)
            self.constellation = try container.decode(String.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.constellation)
            self.major = try container.decode(String.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.major)
            self.clubs = try container.decode([String].self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.clubs)
            self.subwayStations = try container.decode([String].self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.subwayStations)
            self.mbti = try container.decode(String.self, forKey: ResponseDTO.CreateProfileDTO.CodingKeys.mbti)
        }
    }
}

extension ResponseDTO.CreateProfileDTO {
    func toDomain() -> Profile {
        let majors: [Profile.Major] = [.init(name: major, imageName: "")]
        let clubs = clubs
            .map { name -> Profile.Club in
                    .init(name: name, imageName: "")
            }
        let subwayInfos = subwayStations
            .map { name -> SubwayInfo in
                    .init(name: name, lines: [])
            }
        return Profile(
            userCode: userCode,
            userNickname: name,
            birth: birth,
            majors: majors,
            clubs: clubs,
            mbti: mbti,
            constellation: constellation,
            subwayInfos: subwayInfos,
            viewerShip: "0"
        )
    }
}
