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
    
    private let container: DependencyType
    private let useCase = UseCase()
    
    struct UseCase {
        let mbtiBoard = DefaultMBTIBoardUseCase()
    }
    
    init(container: DependencyType) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            profile = container.services.userService.profiles.last ?? .empty
            mbtiTiles = MBTI.allCases.map { mbti in
                let mbti = mbti.rawValue.uppercased()
                let opacity = CGFloat(useCase.mbtiBoard.count(mbti: mbti)) * 0.34
                return (mbti, opacity)
            }
        }
    }
}
