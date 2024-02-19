//
//  ProfileEditorViewBuilder.swift
//  FunchApp
//
//  Created by 이성민 on 2/19/24.
//

import SwiftUI

struct ProfileEditorViewBuilder: Buildable {
    
    var container: DependencyType
    
    init(container: DependencyType) {
        self.container = container
    }
    
    var body: some View {
        let useCase = CreateProfileUseCase()
        let viewModel = ProfileEditorViewModel(container: container, useCase: useCase)
        let view = ProfileEditorView(viewModel: viewModel)
        
        return view
    }
}
