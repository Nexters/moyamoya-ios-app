//
//  MBTIBoardViewModel.swift
//  FunchApp
//
//  Created by 이성민 on 2/23/24.
//

import Foundation

class MBTIBoardViewModel: ObservableObject {
    
    enum Action {
        case load
    }
    
    @Published var profile: Profile = .empty
    @Published var mbtiTiles: [(String, CGFloat)] = []
    
    private let useCase: MBTIBoardUseCase
    
    init(useCase: MBTIBoardUseCase) {
        self.useCase = useCase
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            profile = useCase.profile()
            mbtiTiles = MBTI.allCases.map { mbti in
                let opacity = CGFloat(useCase.count(mbti: mbti.rawValue)) * 0.2
                return (mbti.rawValue, opacity)
            }
        }
    }
}
