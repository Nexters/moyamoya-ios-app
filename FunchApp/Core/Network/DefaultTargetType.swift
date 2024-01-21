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
}

extension DefaultTargetType: TargetType {

    var baseURL: URL {
        guard let url = URL(string: APIEnvironment.develop.urlString) else {
            fatalError("fatal error - invalid api url")
        }
        return url
    }

    var path: String {
        switch self {
        case let .getUserProfile(id):
            return "/user/\(id)"
        case .createUserProfile:
            return "/user/create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserProfile(_):
            return .get
        case .createUserProfile:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .getUserProfile:
            return .requestPlain
        case let .createUserProfile(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
    }
}
