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
            let matchedInfos: [MatchedInfo]
            let subwayChemistryInfo: ChemistryInfo?

            enum CodingKeys: CodingKey {
                case profile
                case similarity
                case chemistryInfos
                case matchedInfos
                case subwayChemistryInfo
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.CodingKeys.self)
                self.profile = try container.decode(ResponseDTO.MatchingUser.DataClass.Profile.self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.profile)
                self.similarity = try container.decode(Int.self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.similarity)
                self.chemistryInfos = try container.decode([ResponseDTO.MatchingUser.DataClass.ChemistryInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.chemistryInfos)
                self.matchedInfos = try container.decode([ResponseDTO.MatchingUser.DataClass.MatchedInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.matchedInfos)
                self.subwayChemistryInfo = try? container.decode(ResponseDTO.MatchingUser.DataClass.ChemistryInfo.self, forKey: ResponseDTO.MatchingUser.DataClass.CodingKeys.subwayChemistryInfo) 
            }
            
            struct Profile: Decodable {
                let name: String
                let jobGroup: String
                let clubs: [String]
                let mbti: String
                let bloodType: String
                let subwayInfos: [SubwayInfo]
                
                enum CodingKeys: CodingKey {
                    case name
                    case jobGroup
                    case clubs
                    case mbti
                    case bloodType
                    case subwayInfos
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.self)
                    self.name = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.name)
                    self.jobGroup = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.jobGroup)
                    self.clubs = try container.decode([String].self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.clubs)
                    self.mbti = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.mbti)
                    self.bloodType = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.bloodType)
                    self.subwayInfos = try container.decode([SubwayInfo].self, forKey: ResponseDTO.MatchingUser.DataClass.Profile.CodingKeys.subwayInfos)
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
            
            struct MatchedInfo: Decodable {
                let title: String
                
                enum CodingKeys: CodingKey {
                    case title
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<ResponseDTO.MatchingUser.DataClass.MatchedInfo.CodingKeys> = try decoder.container(keyedBy: ResponseDTO.MatchingUser.DataClass.MatchedInfo.CodingKeys.self)
                    self.title = try container.decode(String.self, forKey: ResponseDTO.MatchingUser.DataClass.MatchedInfo.CodingKeys.title)
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
            mbti: data.profile.mbti,
            bloodType: data.profile.bloodType,
            subwayNames: data.profile.subwayInfos.map { $0.name }
        )
        
        let chemistryInfos = data.chemistryInfos.map { info -> MatchingInfo.ChemistryInfo in
                .init(title: info.title, description: info.description)
        }
        
        let recommendInfos = data.matchedInfos.map { info -> MatchingInfo.RecommendInfo in
                .init(title: info.title)
        }
        
        var subwayChemistryInfo: MatchingInfo.ChemistryInfo?
        if let subwayInfo = data.subwayChemistryInfo {
            subwayChemistryInfo = .init(
                title: subwayInfo.title,
                description: subwayInfo.description
            )
        } else { subwayChemistryInfo = nil }
        
        return .init(
            profile: profile,
            similarity: data.similarity,
            chemistryInfos: chemistryInfos,
            recommendInfos: recommendInfos,
            subwayChemistryInfo: subwayChemistryInfo
        )
    }
}
