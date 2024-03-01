//
//  ProfileEditorViewBuilder.swift
//  FunchApp
//
//  Created by 이성민 on 2/19/24.
//

import SwiftUI

struct ProfileEditorViewBuilder {
    
    private var diContainer: DIContainer
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    var body: some View {
        let viewModel = makeViewModel()
        let view = ProfileEditorView(viewModel: viewModel)
        
        return view
    }
    
    private func makeViewModel() -> ProfileEditorViewModel {
        .init(
            useCase: .init(
                createProfile: makeDefaultCreateProfileUseCase(),
                searchSubway: makeDefaultSearchSubwayUseCase()
            ), inject: diContainer.inject
        )
    }
    
    private func makeDefaultCreateProfileUseCase() -> DefaultCreateProfileUseCase {
        return .init(profileRepository: diContainer.profileRepository)
    }
    
    private func makeDefaultSearchSubwayUseCase() -> DefaultSearchSubwayUseCase {
        return .init(repository: diContainer.subwayStationRepository)
    }
}
