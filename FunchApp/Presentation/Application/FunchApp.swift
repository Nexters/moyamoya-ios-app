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
    
    @State private var isSplashing: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $appCoordinator.paths) {
                    if !container.services.userService.profiles.isEmpty {
                        HomeViewBuilder(container: container).body
                    } else {
                        OnboardingViewBuilder(container: container).body
                            .navigationDestination(for: AppCoordinatorPathType.self) { type in
                                switch type {
                                case let .onboarding(pathType):
                                    switch pathType {
                                    case .createProfile:
                                        ProfileEditorViewBuilder(container: container).body
                                            .navigationBarBackButtonHidden()
                                    }
                                }
                            }
                    }
                }
                .overlay {
                    if isSplashing {
                        SplashViewBuilder(container: container).body
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isSplashing.toggle()
                }
            }
            .environmentObject(appCoordinator)
            .environmentObject(container)
        }
    }
}
