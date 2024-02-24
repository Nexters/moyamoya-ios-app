//
//  MBTIBoardViewModel.swift
//  FunchApp
//
//  Created by 이성민 on 2/23/24.
//

import Foundation

final class MBTIBoardViewModel: ObservableObject {
    
    enum Action {
        case load
    }
    
    @Published var profile: Profile = .empty
    @Published var mbtiTiles: [(String, CGFloat)] = []
    
    private let useCase = UseCase()
    
    struct UseCase {
        let mbtiBoard = DefaultMBTIBoardUseCase()
    }
    
    init() {}
    
    func send(action: Action) {
        switch action {
        case .load:
            profile = useCase.mbtiBoard.profile()
            mbtiTiles = MBTI.allCases.map { mbti in
                let mbti = mbti.rawValue.uppercased()
                let opacity = CGFloat(useCase.mbtiBoard.count(mbti: mbti)) * 0.2
                return (mbti, opacity)
            }
        }
    }
}
