//
//  FunchApp.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

@main
struct FunchApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.paths) {
                if !container.services.userService.profiles.isEmpty {
                    HomeView()
                } else {
                    OnboardingView()
                        .navigationDestination(for: AppCoordinatorPathType.self) { type in
                            switch type {
                            case let .onboarding(pathType):
                                switch pathType {
                                case .createProfile:
                                    ProfileEditorView()
                                        .navigationBarBackButtonHidden()
                                }
                            }
                        }
                }
            }
        }
        .environmentObject(appCoordinator)
        .environmentObject(container)
        
    }
}
