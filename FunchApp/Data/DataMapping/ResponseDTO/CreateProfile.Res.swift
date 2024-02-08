//
//  ProfileDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import UIKit

extension ResponseDTO {
    struct CreateProfile: Respondable {
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
            let container: KeyedDecodingContainer<ResponseDTO.CreateProfile.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.CreateProfile.CodingKeys.self)
            self.status = try container.decode(Int.self, forKey: ResponseDTO.CreateProfile.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.message)
            self.userCode = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.userCode)
            self.name = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.name)
            self.birth = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.birth)
            self.age = try container.decode(Int.self, forKey: ResponseDTO.CreateProfile.CodingKeys.age)
            self.constellation = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.constellation)
            self.major = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.major)
            self.clubs = try container.decode([String].self, forKey: ResponseDTO.CreateProfile.CodingKeys.clubs)
            self.subwayStations = try container.decode([String].self, forKey: ResponseDTO.CreateProfile.CodingKeys.subwayStations)
            self.mbti = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.mbti)
        }
    }
}

extension ResponseDTO.CreateProfile {
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
            bloodType: constellation,
            subwayInfos: subwayInfos,
            viewerShip: "0"
        )
    }
}
