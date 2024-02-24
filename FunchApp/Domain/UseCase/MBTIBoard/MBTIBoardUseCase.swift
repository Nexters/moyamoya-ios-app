//
//  MBTIBoardUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/23/24.
//

import Foundation

protocol MBTIBoardUseCase {
    func count(mbti: String) -> Int
    func save(mbti: String)
    func profile() -> Profile
}

final class DefaultMBTIBoardUseCase: MBTIBoardUseCase {
    private let repository: MBTIRepository
    
    init() {
        self.repository = MBTIRepository()
    }
    
    func count(mbti: String) -> Int {
        repository.count(mbti: mbti)
    }
    
    func save(mbti: String) {
        repository.save(mbti: mbti)
    }
    
    func profile() -> Profile {
        repository.profile()
    }
}
