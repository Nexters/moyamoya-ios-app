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
    @StateObject private var diContainer = DIContainer()
    
    private var userService = UserDefaultImplement.shared
    
    @State private var isSplashing: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $appCoordinator.paths) {
                    if !userService.profiles.isEmpty {
                        HomeViewBuilder(diContainer: diContainer).body
                    } else {
                        OnboardingViewBuilder().body
                            .navigationDestination(for: AppCoordinatorPathType.self) { type in
                                switch type {
                                case let .onboarding(pathType):
                                    switch pathType {
                                    case .createProfile:
                                        ProfileEditorViewBuilder(diContainer: diContainer).body
                                            .navigationBarBackButtonHidden()
                                    }
                                }
                            }
                    }
                }
                .overlay {
                    if isSplashing {
                        withAnimation(.easeOut) {
                            SplashViewBuilder().body
                        }
                        
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isSplashing.toggle()
                }
            }
            .environmentObject(appCoordinator)
            .environmentObject(diContainer)
        }
    }
}
