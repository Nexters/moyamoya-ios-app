//
//  APIEnvironment.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/22/24.
//

import Foundation

/// 이거 ignore로 해주세요. 추후에 바이너리로 타겟으로 변경할게요.
enum APIEnvironment {
    case develop
    case prodiction
    case staging
    
    /// api base url
    var urlString: String {
        switch self {
        case .develop:
            return Bundle.findStringFromObject(ofDictionaryKey: "BASE_URL") + "api"
        case .prodiction:
            return ""
        case .staging:
            return ""
        }
    }
}

extension Bundle {
    static func findStringFromObject(ofDictionaryKey key: String) -> String {
        guard let domain = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            return ""
        }
        return domain
    }
}
