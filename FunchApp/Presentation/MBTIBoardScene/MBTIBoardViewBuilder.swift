//
//  MBTIBoardViewBuilder.swift
//  FunchApp
//
//  Created by 이성민 on 2/24/24.
//

import SwiftUI

struct MBTIBoardViewBuilder {
    
    private var diContainer: DIContainer
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    var body: some View {
        let viewModel = makeViewModel()
        let view = MBTIBoardView(viewModel: viewModel)
        
        return view
    }
    
    private func makeViewModel() -> MBTIBoardViewModel {
        return .init(
            useCase: .init(mbtiBoard: makeDefaultMBTIBoardUseCase())
        )
    }

    private func makeDefaultMBTIBoardUseCase() -> DefaultMBTIBoardUseCase {
        return .init(repository: diContainer.mbtiRepository)
    }
}
