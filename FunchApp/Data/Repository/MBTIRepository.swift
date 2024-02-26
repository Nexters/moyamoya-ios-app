//
//  MBTIRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/23/24.
//

import Foundation

protocol MBTIRepository {
    func count(mbti: String) -> Int
    func save(mbti: String)
    func profile() -> Profile
}

/// 유저가 mbti board를 확인할 때의 repository
final class MBTIRepositoryImpl: MBTIRepository {
    
    private let services: UserService
    
    init() {
        self.services = UserService.shared
        
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
