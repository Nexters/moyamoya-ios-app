//
//  HomeViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

final class HomeViewBuilder{
    
    private var container: DIContainer
    
    init(_ container: DIContainer) {
        self.container = container
        
    }
    
    var body: some View {
        let view = HomeView(viewModel: self.makeViewModel())
        
        return view
    }
    
    private func makeViewModel() -> HomeViewModel {
        return .init(
            useCase: .init(
                fetchProfile: makeDefaultFetchProfileUseCase(),
                matching: makeDefaultMatchingUseCase(),
                mbti: makeDefaultMBTIBoardUseCase()
            ), 
            container: container
        )
    }
    
    private func makeDefaultFetchProfileUseCase() -> DefaultFetchProfileUseCase {
        return .init(repository: container.dependency.profileRepository)
    }
    
    private func makeDefaultMatchingUseCase() -> DefaultMatchingUseCase {
        return .init(repository: container.dependency.matchingRepository)
    }
    
    private func makeDefaultMBTIBoardUseCase() -> DefaultMBTIBoardUseCase {
        return .init(repository: container.dependency.mbtiRepository)
    }
}

