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
            /// 혈액형
            let bloodType: String
            /// 직군
            let jobGroup: String
            /// 동아리
            let clubs: [String]
            /// 지하철 역
            let subwayStations: [SubwayInfo]
            /// mbti
            let mbti: String
            /// 해당 유저 코드
            let memberCode: String
            /// 프로필 조회 회수
            let viewCount: Int
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case bloodType
                case jobGroup
                case clubs
                case subwayStations = "subwayInfos"
                case mbti
                case memberCode
                case viewCount
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.GetProfile.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.GetProfile.DataClass.CodingKeys.self)
                self.id = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.id)
                self.name = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.name)
                self.bloodType = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.bloodType)
                self.jobGroup = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.jobGroup)
                self.clubs = try container.decode([String].self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.clubs)
                self.subwayStations = try container.decode([SubwayInfo].self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.subwayStations)
                self.mbti = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.mbti)
                self.memberCode = try container.decode(String.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.memberCode)
                self.viewCount = try container.decode(Int.self, forKey: ResponseDTO.GetProfile.DataClass.CodingKeys.viewCount)
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
        let viewCount = String(data.viewCount)
        return Profile(
            id: data.id,
            userCode: data.memberCode,
            userNickname: data.name,
            majors: majors,
            clubs: clubs,
            mbti: data.mbti,
            bloodType: data.bloodType,
            subwayInfos: data.subwayStations,
            viewerShip: viewCount)
    }
}
