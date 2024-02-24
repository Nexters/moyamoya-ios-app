//
//  HomeViewModel.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    
    enum Action: Equatable {
        case load
        case matching
        
        case feedback
        case appstore
        case releaseNote
        
        case presentation(HomePresentation)
    }
    
    @Published var presentation: HomePresentation?
    /// 코드 검색 텍스트 필드
    @Published var searchCodeText: String = ""
    /// 내 프로필
    @Published var profile: Profile?
    /// 매치 실패 시 알러트
    @Published var showingAlert: Bool = false
    
    private var container: DependencyType
    private var useCase = HomeUseCase()
    
    init(container: DependencyType) {
        self.container = container
    }

    var cancellables = Set<AnyCancellable>()
    
    func send(action: Action) {
        switch action {
        case .load:
            useCase.fetchProfile()
                .sink { _ in

                } receiveValue: { [weak self] profile in
                    guard let self else { return }
                    self.profile = profile
                    self.container.services.userService.profiles.append(profile)
                }.store(in: &cancellables)
            
        case .matching:
            guard let profile else { return }
            useCase.matchingProfile(
                requestId: profile.id,
                targetUserCode: searchCodeText
            ) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let matchingInfo):
                    presentation = .matchResult(matchingInfo)
                case .failure(_):
                    showingAlert = true
                }
            }
            
        case .feedback:
            container.services.openURLSerivce.execute(type: .feedback)
            
        case .appstore:
            container.services.openURLSerivce.execute(type: .appstore)
            
        case .releaseNote:
            container.services.openURLSerivce.execute(type: .releaseNote)
            
        case let .presentation(presentation):
            self.presentation = presentation
            
        }
    }
}
