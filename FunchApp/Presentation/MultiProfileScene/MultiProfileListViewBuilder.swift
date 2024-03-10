//
//  MultiProfileListViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/2/24.
//

import SwiftUI

struct MultiProfileListViewBuilder {
    
    private var container: DIContainer
    private var viewModel: MultiProfileListViewModel
    private var delegate: MultiProfileListDelegate
    
    init(
        _ container: DIContainer,
        delegate: MultiProfileListDelegate
    ) {
        self.container = container
        self.delegate = delegate
        
        self.viewModel = .init(
            container: container,
            delegate: delegate
        )
    }
    
    var body: some View {
        let view = MultiProfileListView(viewModel: viewModel)
        
        return view
    }
}
