//
//  MatchResultViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct MatchResultViewBuilder {
    
    private var diContainer: DIContainer
    
    /// 매칭된 타인의 프로필
    private var matchingInfo: MatchingInfo
    
    init(
        diContainer: DIContainer,
        matchingInfo: MatchingInfo
    ) {
        self.diContainer = diContainer
        self.matchingInfo = matchingInfo
    }
    
    var body: some View {
        let viewModel = MatchResultViewModel(
            inject: diContainer.inject,
            matchingInfo: matchingInfo
        )
        let view = MatchResultView(viewModel: viewModel)
        
        return view
    }
}
