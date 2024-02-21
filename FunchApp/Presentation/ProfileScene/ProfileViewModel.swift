//
//  ProfileViewModel.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    enum Action {
        case load
        case loadFailed
        case deleteProfile
        case feedback
    }
    
    enum PresentationState {
        case onboarding
    }
    
    @Published var presentation: PresentationState?
    @Published var profile: Profile?
    @Published var dismiss: Bool = false
    
    private var container: DependencyType
    private var useCase: DeleteProfileUseCaseType
    
    init(container: DependencyType, useCase: DeleteProfileUseCaseType) {
        self.container = container
        self.useCase = useCase
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            guard let profile = container.services.userService.profiles.last else {
                self.send(action: .loadFailed)
                return
            }
            self.profile = profile
            
        case .loadFailed:
            dismiss = true
            
        case .deleteProfile:
            self.container.services.userService.profiles = []
            self.presentation = .onboarding
            
        case .feedback:
            container.services.openURLSerivce.execute(type: .feedback)
            
        }
    }
}
