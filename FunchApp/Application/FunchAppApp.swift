//
//  FunchAppApp.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

@main
struct FunchAppApp: App {
    let createUseCase = CreateProfileUseCase()
    let fetchProfileUseCase = FetchProfileUseCase()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ProfileView()
                    .onAppear {
                        fetchProfileUseCase.fetchProfileFromDeviceId { result in
                            switch result {
                            case .success(let success):
                                break
                            case .failure(let failure):
                                break
                            }
                        }
                    }
            }
            
            
        }
    }
}
