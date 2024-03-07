//
//  MultiProfileListViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/2/24.
//

import SwiftUI

final class MultiProfileListViewBuilder {
    
    private var container: DIContainer
    
    init(_ container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        let viewModel = MultiProfileListViewModel(inject: container.inject)
        let view = MultiProfileListView(viewModel: viewModel)
        
        return view
    }
}
