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
        case home
    }
    
    @Published var presentation: PresentationState?
    @Published var profile: Profile?
    @Published var dismiss: Bool = false
    @Published var alertMessage: Alert?

    // MAKR: - Alert
    @Published var showsAlert: Bool = false
    @Published var alertFeedbackFailed: Bool = false
    
    private var useCase: DeleteProfileUseCase
    private var container: DIContainer
    weak var delegate: ProfileViewDelegate?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        container: DIContainer,
        useCase: DeleteProfileUseCase,
        delegate: ProfileViewDelegate
    ) {
        self.container = container
        self.useCase = useCase
        self.delegate = delegate
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            guard let profile = container.userStorage.selectionProfile else {
                self.send(action: .loadFailed)
                return
            }
            self.profile = profile
            
        case .loadFailed:
            dismiss = true
            
        case .deleteProfile:
            guard let userId = profile?.userId else { return }
            useCase.execute(requestId: userId)
                .sink { _ in
                    
                } receiveValue: { [weak self] _ in
                    guard let self else { return }
                    guard let profile else { return }
                    
                    self.container.userStorage.profiles.remove(profile)
                    self.container.userStorage.selectionProfile = nil
                    
                    if self.container.userStorage.profiles.count == 0 {
                        self.presentation = .onboarding
                    } else {
                        self.presentation = .home
                        delegate?.delete(profile: profile)
                    }
                }
                .store(in: &cancellables)
            
        case .feedback:
            do {
                try container.openUrl.feedback()
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
