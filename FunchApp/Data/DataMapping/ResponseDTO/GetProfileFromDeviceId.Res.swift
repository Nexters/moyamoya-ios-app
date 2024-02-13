//
//  ResponseDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

extension ResponseDTO {
    struct GetProfile: Respondable {
        var status: String
        var message: String
        var data: DataClass

        enum CodingKeys: CodingKey {
            case status
            case message
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.GetProfile.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.GetProfile.CodingKeys.self)
            self.status = try container.decode(String.self, forKey: ResponseDTO.GetProfile.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.GetProfile.CodingKeys.message)
            self.data = try container.decode(ResponseDTO.GetProfile.DataClass.self, forKey: ResponseDTO.GetProfile.CodingKeys.data)
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
            /// 혈액형
            let bloodType: String
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
                case bloodType
                case jobGroup
                case clubs
                case subwayStations
                case mbti
                case memberCode
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.GetProfile.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.GetProfile.DataClass.CodingKeys.self)
                self.id = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.id)
                self.name = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.name)
                self.birth = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.birth)
                self.age = try container.decode(Int.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.age)
                self.bloodType = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.bloodType)
                self.jobGroup = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.jobGroup)
                self.clubs = try container.decode([String].self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.clubs)
                self.subwayStations = try container.decode([String].self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.subwayStations)
                self.mbti = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.mbti)
                self.memberCode = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.memberCode)
            }
        }
    }
}

extension ResponseDTO.GetProfile {
    func toDomain() -> Profile {
        
        let majors: [Profile.Major] = [.init(name: self.data.jobGroup, imageName: self.data.jobGroup)]
        let clubs = data.clubs.map { club -> Profile.Club in
            Profile.Club(name: club, imageName: club)
        }
        let subwayInfos = data.subwayStations.map { name -> SubwayInfo in
                .init(name: name, lines: [])
        }
        return Profile(
            id: data.id,
            userCode: data.memberCode,
            userNickname: data.name,
            birth: data.birth,
            majors: majors,
            clubs: clubs,
            mbti: data.mbti,
            bloodType: data.bloodType,
            subwayInfos: subwayInfos,
            viewerShip: "0")
    }
}
