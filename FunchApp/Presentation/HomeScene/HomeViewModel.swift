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
    private var useCase = UseCase()
    
    struct UseCase {
        let fetchProfile = DefaultFetchProfileUseCase()
        let matching = DefaultMatchingUseCase()
    }
    
    init(container: DependencyType) {
        self.container = container
    }

    var cancellables = Set<AnyCancellable>()
    
    func send(action: Action) {
        switch action {
        case .load:
            useCase.fetchProfile.fetchProfileFromDeviceId()
                .sink { _ in

                } receiveValue: { [weak self] profile in
                    guard let self else { return }
                    self.profile = profile
                    self.container.services.userService.profiles.append(profile)
                }.store(in: &cancellables)
            
        case .matching:
            guard let profile else { return }
            let query = MatchingUserQuery(
                requestId: profile.id,
                targetUserCode: searchCodeText
            )
            
            useCase.matching.execute(query: query)
                .sink { [weak self] completion in
                    guard let self else { return }
                    if case .failure = completion {
                        self.showingAlert = true
                    }

                } receiveValue: { [weak self] matchingInfo in
                    guard let self else { return }
                    self.presentation = .matchResult(matchingInfo)
                }.store(in: &cancellables)
            
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
