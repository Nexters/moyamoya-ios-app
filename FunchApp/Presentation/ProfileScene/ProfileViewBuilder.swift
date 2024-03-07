//
//  ProfileViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct ProfileViewBuilder {
    
    private var container: DIContainer
    
    init(_ container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        let useCase = DefaultDeleteProfileUseCase(profileRepository: container.dependency.profileRepository)
        let viewModel = ProfileViewModel(
            container: container,
            useCase: useCase
        )
        let view = ProfileView(viewModel: viewModel)
        return view
    }
}
