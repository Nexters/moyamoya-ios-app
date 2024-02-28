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
}

final class DefaultMBTIBoardUseCase: MBTIBoardUseCase {
    private let repository: MBTIRepository
    
    init() {
        self.repository = MBTIRepositoryImpl()
    }
    
    /// 입력 mbti와 매치 수 반환
    func count(mbti: String) -> Int {
        repository.count(mbti: mbti)
    }
    
    /// 입력 mbti와 매치한 기록을 저장
    func save(mbti: String) {
        repository.save(mbti: mbti)
    }
}
