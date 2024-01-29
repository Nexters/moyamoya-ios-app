//
//  ResponseDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

extension RequestDTO {
    /// 디바이스 아이디로 프로필을 조회
    struct GetProfileFromDeviceId: Requestable {
        var deviceId: String
        
        init(deviceId: String) {
            self.deviceId = deviceId
        }
        
        var toDitionary: DictionaryType {
            [
                "deviceNumber": deviceId,
            ]
        }
    }
    
    /// 아이디로 프로필을 조회
    struct GetProfileFromId: Requestable {
        
    }
}

extension ResponseDTO {
    struct GetProfileDTO: Respondable {
        var status: Int
        var message: String
        var data: DataClass

        enum CodingKeys: CodingKey {
            case status
            case message
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.GetProfileDTO.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.GetProfileDTO.CodingKeys.self)
            self.status = try container.decode(Int.self, forKey: ResponseDTO.GetProfileDTO.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.CodingKeys.message)
            self.data = try container.decode(ResponseDTO.GetProfileDTO.DataClass.self, forKey: ResponseDTO.GetProfileDTO.CodingKeys.data)
        }
        
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
            
            enum CodingKeys: CodingKey {
                case id
                case name
                case birth
                case age
                case constellation
                case jobGroup
                case clubs
                case subwayStations
                case mbti
                case memberCode
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.GetProfileDTO.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.self)
                self.id = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.id)
                self.name = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.name)
                self.birth = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.birth)
                self.age = try container.decode(Int.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.age)
                self.constellation = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.constellation)
                self.jobGroup = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.jobGroup)
                self.clubs = try container.decode([String].self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.clubs)
                self.subwayStations = try container.decode([String].self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.subwayStations)
                self.mbti = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.mbti)
                self.memberCode = try container.decode(String.self, forKey: ResponseDTO.GetProfileDTO.DataClass.CodingKeys.memberCode)
            }
        }
    }
}

extension ResponseDTO.GetProfileDTO {
    func toDomain() -> Profile {
        
        let majors: [Profile.Major] = [.init(name: self.data.jobGroup, imageName: "")]
        let clubs = data.clubs.map { club -> Profile.Club in
            Profile.Club(name: club, imageName: "")
        }
        let subwayInfos = data.subwayStations.map { name -> SubwayInfo in
                .init(name: name, lines: [])
        }
        return Profile(userCode: data.memberCode,
                userNickname: data.name,
                birth: data.birth,
                majors: majors,
                clubs: clubs,
                mbti: data.mbti,
                constellation: data.constellation,
                subwayInfos: subwayInfos,
                viewerShip: "0")
    }
}
