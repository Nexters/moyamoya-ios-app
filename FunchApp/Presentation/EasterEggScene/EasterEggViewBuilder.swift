//
//  EasterEggViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

struct EasterEggViewBuilder {
    var body: some View {
        let viewModel = EasterEggViewModel()
        let view = EasterEggView(viewModel: viewModel)
        
        return view
    }
}
