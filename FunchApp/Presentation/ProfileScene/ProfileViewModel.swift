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
        case feedback
    }
    
    @Published var profile: Profile?
    @Published var dismiss: Bool = false
    
    private var container: DependencyType
    
    init(container: DependencyType) {
        self.container = container
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
            
        case .feedback:
            container.services.openURLSerivce.execute(type: .feedback)
        }
    }
}
