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
    
    private var applicationUsecase: ApplicationUseCaseType
    
    init() { 
        self.applicationUsecase = ApplicationUseCase(userStorage: .shared)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.paths) {
                if applicationUsecase.hasProfile {
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
        
    }
}
