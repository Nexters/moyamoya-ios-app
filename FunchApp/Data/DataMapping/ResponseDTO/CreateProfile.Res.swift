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
            var major: String
            var clubs: [String]
            var bloodType: String
            var subwayStations: [SubwayInfo]
            var mbti: String
            var viewCount: Int
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case bloodType
                case major = "jobGroup"
                case clubs
                case subwayStations = "subwayInfos"
                case mbti
                case userCode = "memberCode"
                case viewCount
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.CreateProfile.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.CreateProfile.DataClass.CodingKeys.self)
                self.id = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.id)
                self.userCode = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.userCode)
                self.name = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.name)
                self.major = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.major)
                self.clubs = try container.decode([String].self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.clubs)
                self.subwayStations = try container.decode([SubwayInfo].self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.subwayStations)
                self.mbti = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.mbti)
                self.viewCount = try container.decode(Int.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.viewCount)
                self.bloodType = try container.decode(String.self, forKey: ResponseDTO.CreateProfile.DataClass.CodingKeys.bloodType)
            }
            
            struct SubwayInfo: Decodable {
                let name: String
                let lines: [String]
                
                enum CodingKeys: CodingKey {
                    case name
                    case lines
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.SubwayInfo.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.SubwayInfo.CodingKeys.self)
                    self.name = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.SubwayInfo.CodingKeys.name)
                    self.lines = try container.decode([String].self, forKey: ResponseDTO.MatchingUser.DataClass.SubwayInfo.CodingKeys.lines)
                }
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
            .map { subway -> SubwayInfo in
                    .init(name: subway.name, lines: subway.lines)
            }
        return Profile(
            userId: data.id,
            userCode: data.userCode,
            userNickname: data.name,
            majors: majors,
            clubs: clubs,
            mbti: data.mbti, 
            bloodType: data.bloodType,
            subwayInfos: subwayInfos,
            viewerShip: "0"
        )
    }
}
