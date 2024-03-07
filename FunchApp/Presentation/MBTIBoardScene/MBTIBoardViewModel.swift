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
        case loadFailed
    }
    
    @Published var profile: Profile = .empty
    @Published var mbtiTiles: [(String, CGFloat)] = []
    
    private let useCase: UseCase
    private let container: DIContainer
    
    struct UseCase {
        let mbtiBoard: MBTIBoardUseCase
    }
    
    init(
        container: DIContainer,
        useCase: UseCase
        
    ) {
        self.container = container
        self.useCase = useCase
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            guard let selectionProfile = container.userStorage.selectionProfile else {
                send(action: .loadFailed)
                return
            }
            self.profile = selectionProfile
            mbtiTiles = MBTI.allCases.map { mbti in
                let mbti = mbti.rawValue.uppercased()
                let opacity = CGFloat(useCase.mbtiBoard.count(mbti: mbti)) * 0.5
                return (mbti, opacity)
            }
        case .loadFailed:
            break
        }
    }
}
