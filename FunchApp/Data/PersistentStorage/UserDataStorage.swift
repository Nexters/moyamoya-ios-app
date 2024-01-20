//
//  UserDataStorage.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation

final class UserDefaultStorage {

    static let shared: UserDefaultStorage = UserDefaultStorage()

    private init() {}
//
//    @UserDefault(key: UserDefaultKeyCase.widgetInfo, defaultValue: WidgetInfoDTO.defaultValue)
//    var widgetInfo: WidgetInfoDTO

//    @UserDefault(key: UserDefaultKeyCase.hashTagInfos, defaultValue: [])
//    var hashTagInfos: [HashTagInfoDTO]
}

/// `UserDefaultKeyCase`키 값 정보
enum UserDefaultKeyCase: String {
    case widgetInfo = "widget.info"
    case hashTagInfos = "hash.tag.infos"
}

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: UserDefaultKeyCase
    let defaultValue: T
    let storage: UserDefaults

    var wrappedValue: T {
        get {
            guard let data = self.storage.object(forKey: self.key.rawValue) as? Data else { return defaultValue }
            return (try? PropertyListDecoder().decode(T.self, from: data)) ?? self.defaultValue
        }
        set {
            let encodedData = try? PropertyListEncoder().encode(newValue)
            self.storage.set(encodedData, forKey: self.key.rawValue)
        }
    }

    init(key: UserDefaultKeyCase, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}
