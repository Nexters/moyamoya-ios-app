//
//  ProfileEditorViewBuilder.swift
//  FunchApp
//
//  Created by 이성민 on 2/19/24.
//

import SwiftUI

struct ProfileEditorViewBuilder {
    
    private var container: DIContainer
    
    init(_ container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        let viewModel = makeViewModel()
        let view = ProfileEditorView(viewModel: viewModel)
        
        return view
    }
    
    private func makeViewModel() -> ProfileEditorViewModel {
        .init(
            container: container,
            useCase: .init(
                createProfile: makeDefaultCreateProfileUseCase(),
                searchSubway: makeDefaultSearchSubwayUseCase()
            )
        )
    }
    
    private func makeDefaultCreateProfileUseCase() -> DefaultCreateProfileUseCase {
        return .init(profileRepository: container.dependency.profileRepository)
    }
    
    private func makeDefaultSearchSubwayUseCase() -> DefaultSearchSubwayUseCase {
        return .init(repository: container.dependency.subwayStationRepository)
    }
}
