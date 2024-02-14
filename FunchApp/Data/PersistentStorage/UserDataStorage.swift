//
//  UserDataStorage.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import SwiftUI

final class UserDefaultStorage {
    
    static let shared: UserDefaultStorage = UserDefaultStorage()
    
    private init() {}

    /// 해당 사용자가 프로필이 존재하는지 유무
    @AppStorage(UserDefaultKeyCase.hasProfile.rawValue)
    var hasProfile: Bool = false
    
    @AppStorage(UserDefaultKeyCase.profiles.rawValue)
    var profiles: [Profile] = []
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case hasProfile
    case profiles
}


extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let value = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        
        self = value
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else { return "" }
        
        return result
    }
}
