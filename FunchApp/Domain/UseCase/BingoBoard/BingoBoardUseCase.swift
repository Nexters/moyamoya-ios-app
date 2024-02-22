//
//  BingoBoardUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/23/24.
//

import Foundation

final class BingoBoardUseCase {
    private let repository: BingoMBTIRepository
    
    init() {
        self.repository = BingoMBTIRepository()
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
