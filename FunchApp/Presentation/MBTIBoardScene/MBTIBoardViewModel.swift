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
    
    private let useCase: MBTIBoardUseCase
    
    init(useCase: MBTIBoardUseCase) {
        self.useCase = useCase
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            break
        }
    }
}
