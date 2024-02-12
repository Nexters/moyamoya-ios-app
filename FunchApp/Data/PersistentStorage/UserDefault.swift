//
//  UserDefault.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import Foundation

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
            do {
                let encodedData = try PropertyListEncoder().encode(newValue)
                self.storage.set(encodedData, forKey: self.key.rawValue)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    init(key: UserDefaultKeyCase, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}
