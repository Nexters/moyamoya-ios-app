//
//  BingoMBTIRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/23/24.
//

import Foundation

class BingoMBTIRepository {
    
    private let services: UserService
    
    init() {
        self.services = UserService()
        
        self.dictionary = services.bingoMBTIBoard
    }
    
    private var dictionary: [String: Int] = [:]
    
    func count(mbti: String) -> Int {
        return dictionary[mbti] ?? 0
    }
    
    func save(mbti: String) {
        if let count = dictionary[mbti] {
            dictionary.updateValue(count + 1, forKey: mbti)
        } else {
            dictionary[mbti] = 1
        }
        
        services.bingoMBTIBoard = dictionary
    }
    
    func profile() -> Profile {
        return services.profiles.last ?? .empty
    }
}
