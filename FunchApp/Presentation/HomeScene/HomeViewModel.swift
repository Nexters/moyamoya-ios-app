//
//  HomeViewModel.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    
    enum Action {
        case load
        case matching
        
        case feedback
        case appstore
        case releaseNote
        
        case presentation(HomePresentation)
        case alert(Alert)
        case share
    }
    
    @Published var presentation: HomePresentation?
    /// 코드 검색 텍스트 필드
    @Published var searchCodeText: String = ""
    /// 내 프로필
    @Published var profile: Profile?
    /// 액티비티 아이템
    @Published var activityItem: ActivityItem?
    
    // MARK: - Alert
    @Published var showsAlert: Bool = false
    @Published var alertMessage: Alert?
    
    enum Alert {
        case failedMatchingProfile(String)
        case failedFeedback(String)
    }
    
    private var container: DependencyType
    private var useCase = UseCase()
    private var inject = Inject()
    
    struct UseCase {
        let fetchProfile = DefaultFetchProfileUseCase()
        let matching = DefaultMatchingUseCase()
    }
    
    struct Inject {
        let openUrl: OpenURLProviderType = OpenURLProvider.shared
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
            guard searchCodeText.count == 4 else { return }
            
            guard searchCodeText != profile.userCode else {
                self.send(action: .presentation(.easterEgg))
                return
            }
            
            let query = MatchingUserQuery(
                requestId: profile.id,
                targetUserCode: searchCodeText
            )
            
            useCase.matching.execute(query: query)
                .sink { [weak self] completion in
                    guard let self else { return }
                    if case .failure = completion {
                        // !!!: 이거 failure 처리 어떻게 할건지 고민
                        self.send(action: .alert(.failedMatchingProfile("프로필 조회에 실패했어요.")))
                    }

                } receiveValue: { [weak self] matchingInfo in
                    guard let self else { return }
                    self.presentation = .matchResult(matchingInfo)
                }.store(in: &cancellables)
            
        case .feedback:
            do {
                try inject.openUrl.feedback()
            } catch let error {
                self.send(action: .alert(.failedFeedback(error.localizedDescription)))
            }
            
        case .appstore:
            do {
                try inject.openUrl.appstore()
            } catch {
                
            }
            
        case .releaseNote:
            do {
                try inject.openUrl.releaseNote()
            } catch {
                
            }
            
        case let .presentation(presentation):
            self.presentation = presentation
            
        case let .alert(type):
            showsAlert = true
            alertMessage = type
            
        case .share:
            activityItem = .init(items: "펀치앱 바로가기")
            break
        }
    }
}
