//
//  HomeViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

final class HomeViewBuilder {
    var body: some View {
        let viewModel = HomeViewModel()
        let view = HomeView(viewModel: viewModel)
        
        return view
    }
}

