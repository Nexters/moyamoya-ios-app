//
//  MultiProfileListViewModel.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/2/24.
//

import SwiftUI

final class MultiProfileListViewModel: ObservableObject {
    
    enum Action {
        case load
        case selection(Profile)
        case presentation(MultiProfileListPresentation)
        case dismiss
    }
    
    @Published var presentation: MultiProfileListPresentation?
    /// 프로필 목록
    @Published var profiles: [Profile] = [.empty, .testableValue]
    /// 유저가 선택한 프로필
    @Published var selection: Profile?
    @Published var dismiss: Bool = false
    
    private var container: DIContainer
    weak var delegate: MultiProfileListDelegate?
    
    init(
        container: DIContainer,
        delegate: MultiProfileListDelegate
    ) {
        self.container = container
        self.delegate = delegate
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            self.profiles = container.userStorage.profiles.sorted { $0.createAt > $1.createAt }
            
            self.selection = container.userStorage.selectionProfile == nil
            ? self.profiles.first
            : self.container.userStorage.selectionProfile
            
        case let .selection(profile):
            container.userStorage.selectionProfile = profile
            self.selection = profile
        
        case let .presentation(presentation):
            self.presentation = presentation
            
        case .dismiss:
            guard let profile = self.selection else { return }
            delegate?.change(profile: profile)
            dismiss = true
        }
    }
}
