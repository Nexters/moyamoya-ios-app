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
            guard let userId = profile?.id else {
                // TODO: 내가 프로필이 없다면 ?
                return
            }
            useCase.deleteProfile(requestId: userId) { result in
                switch result {
                case .success(let deletedId):
                    // TODO: profiles 중에서 deletedId를 찾아 없애는 작업 필요
                    // TODO: UserDefaults에서 Profile 형태가 아닌 Profile.id 형태로 저장 필요
                    self.container.services.userService.profiles = []
                    self.presentation = .onboarding
                case .failure(_):
                    // 실패했을때는 어떤 처리 ...? 또 알러트 ??
                    break
                }
            }
            
        case .feedback:
            container.services.openURLSerivce.execute(type: .feedback)
        }
    }
}
