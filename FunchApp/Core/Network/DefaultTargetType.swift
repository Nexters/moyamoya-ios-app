//
//  DefaultTargetType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation
import Moya

/// 앱 서비스에서 사용하는 기본 타겟
enum DefaultTargetType {
    /// 본인 프로필 id 기반으로 조회
    case getUserProfileFromId(path: String)
    /// 본인 프로필 디바이스 기반으로 조회
    case getUserProfileFromDeviceId(parameters: DictionaryType)
    /// 본인 프로필 생성
    case createUserProfile(parameters: DictionaryType)
    /// 지하철 역 검색
    case searchSubwayStations(parameters: DictionaryType)
    /// 타인 프로필 검색
    case matchingUser(parameters: DictionaryType)
    /// 프로필 삭제
    case deleteUserProfile(path: String)
}

extension DefaultTargetType: TargetType {

    var baseURL: URL {
        guard let url = URL(string: APIEnvironment.develop.urlString) else {
            fatalError("❗️URL 타입 변환에 실패했습니다.")
        }
        return url
    }

    var path: String {
        switch self {
        case let .getUserProfileFromId(id):
            return "/v1/members/\(id)"
        case .getUserProfileFromDeviceId(_):
            return "/v1/members"
        case .matchingUser(_):
            return "/v1/matching"
        case .createUserProfile:
            return "/v1/members"
        case .searchSubwayStations(_):
            return "/v1/subway-stations/search"
        case let .deleteUserProfile(id):
            return "v1/members/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfileFromId(_),
                .getUserProfileFromDeviceId(_),
                .searchSubwayStations(_):
            return .get
            
        case .createUserProfile(_),
                .matchingUser(_):
            return .post
            
        case .deleteUserProfile(_):
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .getUserProfileFromId(_), .deleteUserProfile(_):
            return .requestPlain
            
        case .getUserProfileFromDeviceId(let parameters),
                .searchSubwayStations(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .createUserProfile(let parameters),
                .matchingUser(let parameters):
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            return .requestData(jsonData)
            
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
        ]
    }
}
