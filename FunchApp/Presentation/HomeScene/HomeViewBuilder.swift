//
//  HomeViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

final class HomeViewBuilder {
    
    private var diContainer: DIContainer
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    var body: some View {
        let viewModel = makeViewModel()
        let view = HomeView(viewModel: viewModel)
        
        return view
    }
    
    private func makeViewModel() -> HomeViewModel {
        return .init(
            useCase: .init(
                fetchProfile: makeDefaultFetchProfileUseCase(),
                matching: makeDefaultMatchingUseCase(),
                mbti: makeDefaultMBTIBoardUseCase()
            ), 
            inject: diContainer.inject
        )
    }
    
    private func makeDefaultFetchProfileUseCase() -> DefaultFetchProfileUseCase {
        return .init(repository: diContainer.profileRepository)
    }
    
    private func makeDefaultMatchingUseCase() -> DefaultMatchingUseCase {
        return .init(repository: diContainer.matchingRepository)
    }
    
    private func makeDefaultMBTIBoardUseCase() -> DefaultMBTIBoardUseCase {
        return .init(repository: diContainer.mbtiRepository)
    }
}

