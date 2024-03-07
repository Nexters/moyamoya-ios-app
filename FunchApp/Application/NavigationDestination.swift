//
//  NavigationDestination.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/8/24.
//

import SwiftUI

struct NavigationDestintationView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .onboarding:
            OnboardingViewBuilder().body
        case .home:
            HomeViewBuilder(container).body
        case .createProfile:
            ProfileEditorViewBuilder(container).body
        }
    }
}

enum NavigationDestination {
    /// 온보딩
    case onboarding
    /// 홈
    case home
    /// 프로필 생성
    case createProfile
}
