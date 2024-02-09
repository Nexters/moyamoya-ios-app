//
//  MatchingUser.Res.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/29/24.
//

import Foundation

extension ResponseDTO {
    struct MatchingUser: Respondable {
        var status: Int
        var message: String
        var data: DataClass
        
        enum CodingKeys: CodingKey {
            case status
            case message
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.CodingKeys.self)
            self.status = try container.decode(Int.self, forKey: ResponseDTO.MatchingUser.CodingKeys.status)
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
                self.profile = try container.decode(ResponseDTO.MatchingUser.Profile.self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.profile)
                self.similarity = try container.decode(Int.self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.similarity)
                self.chemistryInfos = try container.decode([ResponseDTO.MatchingUser.ChemistryInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.chemistryInfos)
                self.recommendInfos = try container.decode([ResponseDTO.MatchingUser.RecommendInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.recommendInfos)
                self.subwayInfos = try container.decode([ResponseDTO.MatchingUser.SubwayInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.subwayInfos)
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
                let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.ChemistryInfo.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.ChemistryInfo.CodingKeys.self)
                self.title = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.ChemistryInfo.CodingKeys.title)
                self.description = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.ChemistryInfo.CodingKeys.description)
            }
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
                case bloodType
                case subwayNames
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.Profile.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.Profile.CodingKeys.self)
                self.name = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.Profile.CodingKeys.name)
                self.jobGroup = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.Profile.CodingKeys.jobGroup)
                self.clubs = try container.decode([String].self, forKey: ResponseDTO.MatchingUser.Profile.CodingKeys.clubs)
                self.mbti = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.Profile.CodingKeys.mbti)
                self.bloodType = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.Profile.CodingKeys.bloodType)
                self.subwayNames = try container.decode([String].self, forKey: ResponseDTO.MatchingUser.Profile.CodingKeys.subwayNames)
            }
        }
        
        struct RecommendInfo: Decodable {
            let title: String
            
            enum CodingKeys: CodingKey {
                case title
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.RecommendInfo.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.RecommendInfo.CodingKeys.self)
                self.title = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.RecommendInfo.CodingKeys.title)
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
                let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.SubwayInfo.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.SubwayInfo.CodingKeys.self)
                self.name = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.SubwayInfo.CodingKeys.name)
                self.lines = try container.decode([String].self, forKey: ResponseDTO.MatchingUser.SubwayInfo.CodingKeys.lines)
            }
        }
    }
}

