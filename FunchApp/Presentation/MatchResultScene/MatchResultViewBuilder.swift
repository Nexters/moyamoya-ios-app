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
    private var otherProfile: Profile
    
    init(
        container: DIContainer,
        otherProfile: Profile
    ) {
        self.container = container
        self.otherProfile = otherProfile
    }
    
    var body: some View {
        // !!!: - 매칭 프로필에 다른 사람 프로필 넣어주세요.
        let viewModel = MatchResultViewModel(container: container)
        let view = MatchResultView(viewModel: viewModel)
        
        return view
    }
}
