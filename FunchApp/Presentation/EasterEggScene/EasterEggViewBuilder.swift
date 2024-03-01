//
//  EasterEggViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

struct EasterEggViewBuilder {
    var diContainer: DIContainer
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    var body: some View {
        let viewModel = EasterEggViewModel(inject: diContainer.inject)
        let view = EasterEggView(viewModel: viewModel)
        
        return view
    }
}
