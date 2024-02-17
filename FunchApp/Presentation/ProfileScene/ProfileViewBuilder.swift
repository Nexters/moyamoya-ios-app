//
//  ProfileViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct ProfileViewBuilder {
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        let viewModel = ProfileViewModel(container: container)
        let view = ProfileView(viewModel: viewModel)
        
        return view
    }
}
