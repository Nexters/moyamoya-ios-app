//
//  FunchApp.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

@main
struct FunchApp: App {

    @StateObject private var container = DIContainer()
    
    @State private var isSplashing: Bool = true
    
    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $container.paths) {
                    if !container.userStorage.profiles.isEmpty {
                        HomeViewBuilder(container).body
                    } else {
                        OnboardingViewBuilder().body
                            .navigationDestination(for: NavigationDestination.self) {
                                NavigationDestintationView(destination: $0)
                                    .navigationBarBackButtonHidden()
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                    isSplashing.toggle()
                }
            }
            .environmentObject(container)
        }
    }
}

extension FunchApp {
    private func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray900
        ]
        navigationBarAppearance.backgroundColor = UIColor.gray900
        navigationBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
