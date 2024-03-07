//
//  MBTIBoardViewBuilder.swift
//  FunchApp
//
//  Created by 이성민 on 2/24/24.
//

import SwiftUI

struct MBTIBoardViewBuilder {
    
    private var container: DIContainer
    
    init(_ container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        let viewModel = makeViewModel()
        let view = MBTIBoardView(viewModel: viewModel)
        
        return view
    }
    
    private func makeViewModel() -> MBTIBoardViewModel {
        .init(
            container: container,
            useCase: .init(mbtiBoard: makeDefaultMBTIBoardUseCase())
        )
    }

    private func makeDefaultMBTIBoardUseCase() -> DefaultMBTIBoardUseCase {
        return .init(repository: container.dependency.mbtiRepository)
    }
}
