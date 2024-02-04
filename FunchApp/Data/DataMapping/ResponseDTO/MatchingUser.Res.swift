//
//  MatchingUser.Res.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/29/24.
//

import Foundation

extension ResponseDTO {
    struct MatchingUser: Respondable {
        var status: String
        var message: String
        var data: DataClass
        
        enum CodingKeys: CodingKey {
            case status
            case message
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.CodingKeys.self)
            self.status = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.CodingKeys.status)
            self.message = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.CodingKeys.message)
            self.data = try container.decode(ResponseDTO.MatchingUser.DataClass.self, forKey: ResponseDTO.MatchingUser.CodingKeys.data)
        }
        
        struct DataClass: Decodable {
            let profile: Profile
            let similarity: Int
            let chemistryInfos: [ChemistryInfo]
            let recommendInfos: [RecommendInfo]
            let subwayInfos: [SubwayInfo]

            enum CodingKeys: CodingKey {
                case profile
                case similarity
                case chemistryInfos
                case recommendInfos
                case subwayInfos
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.CodingKeys.self)
                self.profile = try container.decode(ResponseDTO.MatchingUser.DataClass.Profile.self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.profile)
                self.similarity = try container.decode(Int.self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.similarity)
                self.chemistryInfos = try container.decode([ResponseDTO.MatchingUser.DataClass.ChemistryInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.chemistryInfos)
                self.recommendInfos = try container.decode([ResponseDTO.MatchingUser.DataClass.RecommendInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.recommendInfos)
                self.subwayInfos = try container.decode([ResponseDTO.MatchingUser.DataClass.SubwayInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.subwayInfos)
            }
            
            struct Profile: Decodable {
                let name: String
                let jobGroup: String
                let clubs: [String]
                let mbti: String
                let bloodType: String
                let subwayNames: [String]
                
                enum CodingKeys: CodingKey {
                    case name
                    case jobGroup
                    case clubs
                    case mbti
                    case constellation
                    case subwayNames
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.self)
                    self.name = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.name)
                    self.jobGroup = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.jobGroup)
                    self.clubs = try container.decode([String].self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.clubs)
                    self.mbti = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.mbti)
                    self.bloodType = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.constellation)
                    self.subwayNames = try container.decode([String].self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.subwayNames)
                }
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
            
            struct ChemistryInfo: Decodable {
                let title: String
                let description: String
                
                enum CodingKeys: CodingKey {
                    case title
                    case description
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.ChemistryInfo.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.ChemistryInfo.CodingKeys.self)
                    self.title = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.ChemistryInfo.CodingKeys.title)
                    self.description = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.ChemistryInfo.CodingKeys.description)
                }
            }
            
            struct RecommendInfo: Decodable {
                let title: String
                
                enum CodingKeys: CodingKey {
                    case title
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.RecommendInfo.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.RecommendInfo.CodingKeys.self)
                    self.title = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.RecommendInfo.CodingKeys.title)
                }
            }
        }
        
    }
}

extension ResponseDTO.MatchingUser {
    func toDomain() -> MatchingInfo {
        
        let profile = MatchingInfo.MatchProfile(
            name: data.profile.name,
            major: data.profile.jobGroup,
            clubs: data.profile.clubs,
            mbti: data.profile.jobGroup,
            bloodType: data.profile.bloodType,
            subwayNames: data.profile.subwayNames
        )
        
        let chemistryInfos = data.chemistryInfos.map { info -> MatchingInfo.ChemistryInfo in
                .init(title: info.title, description: info.description)
        }
        
        let recommendInfos = data.recommendInfos.map { info -> MatchingInfo.RecommendInfo in
                .init(title: info.title)
        }
        
        let subwayInfos = data.subwayInfos.map { info -> SubwayInfo in
                .init(name: info.name, lines: info.lines)
        }
        
        return .init(
            profile: profile,
            similarity: data.similarity,
            chemistryInfos: chemistryInfos,
            recommendInfos: recommendInfos,
            subwayInfos: subwayInfos
        )
    }
}
