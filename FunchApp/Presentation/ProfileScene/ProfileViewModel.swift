//
//  ProfileViewModel.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI
import Combine

final class ProfileViewModel: ObservableObject {
    
    enum Action {
        case load
        case loadFailed
        case deleteProfile
        case feedback
        case alert(Alert)
    }
    
    enum Alert {
        case deleteProile
        case feedbackFailed(String)
    }
    
    enum PresentationState {
        case onboarding
    }
    
    @Published var presentation: PresentationState?
    @Published var profile: Profile?
    @Published var dismiss: Bool = false
    @Published var alertMessage: Alert?

    // MAKR: - Alert
    @Published var showsAlert: Bool = false
    @Published var alertFeedbackFailed: Bool = false
    
    private var useCase: DeleteProfileUseCase
    private var inject: DIContainer.Inject
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        useCase: DeleteProfileUseCase,
        inject: DIContainer.Inject
    ) {
        self.useCase = useCase
        self.inject = inject
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            guard let profile = inject.userStorage.profiles.last else {
                self.send(action: .loadFailed)
                return
            }
            self.profile = profile
            
        case .loadFailed:
            dismiss = true
            
        case .deleteProfile:
            guard let userId = profile?.id else { return }
            
            useCase.execute(requestId: userId)
                .sink { _ in
                    
                } receiveValue: { [weak self] deletedId in
                    guard let self else { return }
                    self.inject.userStorage.profiles = []
                    self.presentation = .onboarding
                }
                .store(in: &cancellables)
            
        case .feedback:
            do {
                try inject.openUrl.feedback()
            } catch let error {
                showsAlert = true
                alertMessage = .feedbackFailed(error.localizedDescription)
            }
            
        case let .alert(type):
            showsAlert = true
            alertMessage = type
        }
        
    }
}
