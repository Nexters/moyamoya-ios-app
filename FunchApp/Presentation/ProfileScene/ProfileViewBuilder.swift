//
//  ProfileViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct ProfileViewBuilder {
//    var container: DependencyType
    
//    init(container: DependencyType) {
//        self.container = container
//    }
    
    var body: some View {
        let useCase = DefaultDeleteProfileUseCase()
        let viewModel = ProfileViewModel(useCase: useCase)
        let view = ProfileView(viewModel: viewModel)
        
        return view
    }
}
