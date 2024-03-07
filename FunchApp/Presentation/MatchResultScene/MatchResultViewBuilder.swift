//
//  MatchResultViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct MatchResultViewBuilder {
    
    private var container: DIContainer
    
    /// 매칭된 타인의 프로필
    private var matchingInfo: MatchingInfo
    
    init(
        _ container: DIContainer,
        matchingInfo: MatchingInfo
    ) {
        self.container = container
        self.matchingInfo = matchingInfo
    }
    
    var body: some View {
        let viewModel = MatchResultViewModel(
            inject: container.inject,
            matchingInfo: matchingInfo
        )
        let view = MatchResultView(viewModel: viewModel)
        
        return view
    }
}
