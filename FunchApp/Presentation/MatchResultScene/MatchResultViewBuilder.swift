//
//  MatchResultViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct MatchResultViewBuilder: Buildable {
    
    var container: DependencyType
    /// 매칭된 타인의 프로필
    private var matchingInfo: MatchingInfo
    
    init(
        container: DependencyType,
        matchingInfo: MatchingInfo
    ) {
        self.container = container
        self.matchingInfo = matchingInfo
    }
    
    var body: some View {
        // !!!: - 매칭 프로필에 다른 사람 프로필 넣어주세요.
        let viewModel = MatchResultViewModel(container: container, matchingInfo: matchingInfo)
        let view = MatchResultView(viewModel: viewModel)
        
        return view
    }
}
