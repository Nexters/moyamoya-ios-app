//
//  ProfileDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import UIKit

extension ResponseDTO {
    struct CreateProfile: Respondable {
        var status: String
        var message: String
        var data: DataClass
        
        struct DataClass: Decodable {
            /// id로 조회할 때 사용
            var id: String
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
                case id
                case userCode = "memberCode"
                case name
                case birth
                case age
                case constellation
                case major = "jobGroup"
                case clubs
                case subwayStations
                case mbti
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.CreateProfile.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.CreateProfile.DataClass.CodingKeys.self)
                self.id = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.id)
                self.userCode = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.userCode)
                self.name = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.name)
                self.birth = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.birth)
                self.age = try container.decode(Int.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.age)
                self.constellation = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.constellation)
                self.major = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.major)
                self.clubs = try container.decode([String].self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.clubs)
                self.subwayStations = try container.decode([String].self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.subwayStations)
                self.mbti = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.mbti)
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case status
            case message
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.CreateProfile.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.CreateProfile.CodingKeys.self)
            self.status = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.CodingKeys.message)
            self.data = try container.decode(ResponseDTO.CreateProfile.DataClass.self, forKey: ResponseDTO.CreateProfile.CodingKeys.data)
        }
    }
}

extension ResponseDTO.CreateProfile {
    func toDomain() -> Profile {
        let majors: [Profile.Major] = [.init(name: data.major, imageName: "")]
        
        let clubs = data.clubs
            .map { name -> Profile.Club in
                    .init(name: name, imageName: "")
            }
        let subwayInfos = data.subwayStations
            .map { name -> SubwayInfo in
                    .init(name: name, lines: [])
            }
        return Profile(
            userCode: data.userCode,
            userNickname: data.name,
            birth: data.birth,
            majors: majors,
            clubs: clubs,
            mbti: data.mbti,
            constellation: data.constellation,
            subwayInfos: subwayInfos,
            viewerShip: "0"
        )
    }
}
