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
    /// `본인 프로필` 조회
    case getUserProfile(id: String)
    /// `본인 프로필` 생성
    case createUserProfile(parameters: DictionaryType)
    /// `지하철 역` 검색
    case searchSubwayStations(parameters: DictionaryType)
    /// `타인 프로필` 검색
    case searchUser(parameters: DictionaryType)
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
        case let .getUserProfile(id):
            return "/user/\(id)"
        case .createUserProfile:
            return "/user/create"
        case .searchSubwayStations(_):
            return "search/subways"
        case .searchUser(_):
            return "search/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfile(_),
                .searchSubwayStations(_),
                .searchUser(_):
            return .get
        case .createUserProfile:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .getUserProfile:
            return .requestPlain
        case let .createUserProfile(parameters),
            let .searchSubwayStations(parameters),
            let .searchUser(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
    }
}
