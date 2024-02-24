//
//  HomeViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct HomeViewBuilder: Buildable {
    var container: DependencyType
    
    init(container: DependencyType) {
        self.container = container
    }
    
    var body: some View {
        let viewModel = HomeViewModel(container: container)
        let view = HomeView(viewModel: viewModel)
        
        return view
    }
}
