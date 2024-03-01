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
            guard let selectionProfile = inject.userStorage.selectionProfile else {
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
