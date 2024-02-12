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
}

enum AppCoordinatorPathType: Hashable {
    case onboarding
    case home
}
