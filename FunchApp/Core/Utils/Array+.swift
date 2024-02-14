//
//  Array+.swift
//  FunchApp
//
//  Created by 이성민 on 2/15/24.
//

import Foundation

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
