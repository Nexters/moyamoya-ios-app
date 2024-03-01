//
//  ProfileViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct ProfileViewBuilder {
    
    private var diContainer: DIContainer
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    var body: some View {
        let useCase = DefaultDeleteProfileUseCase(profileRepository: diContainer.profileRepository)
        let viewModel = ProfileViewModel(
            useCase: useCase,
            inject: diContainer.inject
        )
        let view = ProfileView(viewModel: viewModel)
        return view
    }
}
