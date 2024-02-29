//
//  ProfileEditorViewBuilder.swift
//  FunchApp
//
//  Created by 이성민 on 2/19/24.
//

import SwiftUI

struct ProfileEditorViewBuilder {
    
    var body: some View {
        let viewModel = ProfileEditorViewModel()
        let view = ProfileEditorView(viewModel: viewModel)
        
        return view
    }
}
