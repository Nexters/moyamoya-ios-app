//
//  HomeViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

final class HomeViewBuilder {
    var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        let useCase = HomeUseCase()
        let viewModel = HomeViewModel(container: container, useCase: useCase)
        let homeView = HomeView(viewModel: viewModel)
        
        return homeView
    }
}
