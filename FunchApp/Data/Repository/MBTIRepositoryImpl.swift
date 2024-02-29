//
//  MBTIRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/23/24.
//

import Foundation

/// 유저가 mbti board를 확인할 때의 repository
final class MBTIRepositoryImpl: MBTIRepository {
    
    private let services: UserService
    private var mbtiBoardDictionary: [String: Int]
    
    init() {
        self.services = UserService.shared
        self.mbtiBoardDictionary = services.mbtiBoard
    }
    
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
}
