//
//  MBTIBoardViewBuilder.swift
//  FunchApp
//
//  Created by 이성민 on 2/24/24.
//

import SwiftUI

struct MBTIBoardViewBuilder {
    
    var body: some View {
        let viewModel = MBTIBoardViewModel()
        let view = MBTIBoardView(viewModel: viewModel)
        
        return view
    }
}
