//
//  EasterEggViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

struct EasterEggViewBuilder {
    var container: DIContainer
    
    init(_ container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        let viewModel = EasterEggViewModel(container: container)
        let view = EasterEggView(viewModel: viewModel)
        
        return view
    }
}
