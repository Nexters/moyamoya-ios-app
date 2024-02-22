//
//  ProfileViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct ProfileViewBuilder: Buildable {
    var container: DependencyType
    
    init(container: DependencyType) {
        self.container = container
    }
    
    var body: some View {
        let useCase = DeleteProfileUseCase()
        let viewModel = ProfileViewModel(container: container, useCase: useCase)
        let view = ProfileView(viewModel: viewModel)
        
        return view
    }
}
