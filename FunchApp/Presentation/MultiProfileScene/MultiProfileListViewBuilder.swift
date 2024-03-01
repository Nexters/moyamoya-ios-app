//
//  MultiProfileListViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/2/24.
//

import SwiftUI

final class MultiProfileListViewBuilder {
    
    private var diContainer: DIContainer
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    
    var body: some View {
        let viewModel = MultiProfileListViewModel(inject: diContainer.inject)
        let view = MultiProfileListView(viewModel: viewModel)
        
        return view
    }
}
