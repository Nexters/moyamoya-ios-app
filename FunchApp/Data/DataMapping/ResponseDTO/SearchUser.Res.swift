//
//  SearchUserDTO.Response.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/27/24.
//

import Foundation

extension ResponseDTO {
    struct SearchUser: Respondable {
        var status: String
        var message: String
        var data: DataClass
        
        /// 데이터 클래스
        struct DataClass: Decodable {
            let matchingItems: MatchingItems
            let bloodTypeChemistry: bloodTypeChemistry
            let subwayInfo: SubwayInfo
            let matchingRatio: Int
            let topic: TargetProfile
            let isExistTopic: Bool
            let targetProfile: TargetProfile
            
            /// 혈액형 케미
            struct bloodTypeChemistry: Decodable {
                let referenceBloodType, targetBloodType: String
                let isEqualBloodType: Bool
                let description: Description
            }

            /// 설명
            struct Description: Decodable {
                let text: String
                let highlightText: String
                let highlightColor: String
                let highlightColorOpacity: String
            }

            /// MBTI 아이템
            struct MatchingItems: Decodable {
                let mbtiChemistry: MbtiChemistry
                /// MBTI 케미
                struct MbtiChemistry: Decodable {
                    let referenceMbti: String
                    let targetMbti: String
                    let isEqualMbti: Bool
                    let description: Description
                }
            }

            /// 지하철 정보
            struct SubwayInfo: Decodable {
                let matchingLines: [String]
                let description: Description
            }

            /// 상대방 프로필
            struct TargetProfile: Decodable {
                let jobGroup: String
                let clubs: [String]
                let mbti, bloodType: String
                let subwayStations: [SubwayStation]
                
                /// 지하철 역
                struct SubwayStation: Decodable {
                    let name: String
                    let lines: [String]
                }
            }
        }
    }
}

extension ResponseDTO.SearchUser {
    func toDomain() {
//        let majors: [Profile.Major] = [
//            .init(name: data.targetProfile.jobGroup, imageName: "")
//        ]
//        let clubs = data.targetProfile.clubs.map { clubName -> Profile.Club in
//            return .init(name: clubName, imageName: "")
//        }
//        
//        
//        let targetProfile = Profile(
//            userCode: "",
//            userNickname: "",
//            birth: "",
//            major: majors,
//            club: clubs,
//            mbti: data.targetProfile.mbti,
//            bloodType: data.targetProfile.bloodType,
//            subwayName: data.targetProfile.,
//            viewerShip: ""
//        )
////        
////        
////        .init(profile: <#T##Profile#>,
////              similarity: <#T##Int#>,
////              synergyInfo: <#T##MatchingInfo.SynergyInfo#>,
////              recommendInfo: <#T##MatchingInfo.RecommendInfo#>,
////              matchingSubwayStatitons: <#T##[String]#>
////        )
        
    }
}

