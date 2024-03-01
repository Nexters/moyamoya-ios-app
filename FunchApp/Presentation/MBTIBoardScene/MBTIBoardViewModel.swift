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
    
    private let useCase: UseCase
    private let inject: DIContainer.Inject
    
    struct UseCase {
        let mbtiBoard: MBTIBoardUseCase
    }
    
    init(
        useCase: UseCase,
        inject: DIContainer.Inject
    ) {
        self.useCase = useCase
        self.inject = inject
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            profile = inject.userStorage.profiles.first ?? .empty
            mbtiTiles = MBTI.allCases.map { mbti in
                let mbti = mbti.rawValue.uppercased()
                let opacity = CGFloat(useCase.mbtiBoard.count(mbti: mbti)) * 0.34
                return (mbti, opacity)
            }
        }
    }
}
