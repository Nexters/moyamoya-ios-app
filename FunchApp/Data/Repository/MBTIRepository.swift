//
//  MBTIRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/23/24.
//

import Foundation

class MBTIRepository {
    
    private let services: UserService
    
    init() {
        self.services = UserService()
        
        self.mbtiBoardDictionary = services.mbtiBoard
    }
    
    private var mbtiBoardDictionary: [String: Int]
    
    func count(mbti: String) -> Int {
        return mbtiBoardDictionary[mbti] ?? 0
    }
    
    func save(mbti: String) {
        if let count = mbtiBoardDictionary[mbti] {
            mbtiBoardDictionary.updateValue(count + 1, forKey: mbti)
        } else {
            mbtiBoardDictionary[mbti] = 1
        }
        
        services.mbtiBoard = mbtiBoardDictionary
    }
    
    func profile() -> Profile {
        return services.profiles.last ?? .empty
    }
}
