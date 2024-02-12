//
//  AppCoordinator.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import Foundation

final class AppCoordinator: ObservableObject {
    @Published var paths: [AppCoordinatorPathType]
    
    init(paths: [AppCoordinatorPathType] = []) {
        self.paths = paths
    }
    
    /// 프로필을 가진 경우
    var hasProfile: Bool = false
}

enum AppCoordinatorPathType: Hashable {
    case onboarding(OnboardingPathType)
    case home
}

enum OnboardingPathType: Hashable {
    case createProfile
}
