//
//  FunchAppApp.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

@main
struct FunchAppApp: App {
    
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.paths) {
                HomeView()
                    .navigationDestination(for: AppCoordinatorPathType.self) { type in
                        switch type {
                        default: EmptyView()
                        }
                    }
            }
        }
    }
}
