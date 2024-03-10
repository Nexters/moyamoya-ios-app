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
        case saveMBTI(String)
        
        case feedback
        case appstore
        case releaseNote
        case update
        
        case presentation(HomePresentation)
        case alert(Alert)
    }
    
    @Published var presentation: HomePresentation?
    /// 코드 검색 텍스트 필드
    @Published var searchCodeText: String = ""
    /// 내 프로필
    @Published var profile: Profile?
    
    // MARK: - Alert
    @Published var showsAlert: Bool = false
    @Published var alertMessage: Alert?
    
    private(set) var shareLink = ShareLink()
    
    /// 외부에 공유하기 기능
    struct ShareLink {
        var item = LinkStringSet.appstore.rawValue
        
        func message(userCode: String) -> Text {
            let string = """
            
            너랑나랑 펀치할래?
            
            🌱 초대코드: \(userCode)
            """
            
            return Text(string)
        }
    }
    
    enum Alert {
        case failedMatchingProfile(String)
        case failedFeedback(String)
    }
    
    private var useCase: UseCase
    private var container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    struct UseCase {
        let fetchProfile: DefaultFetchProfileUseCase
        let matching: DefaultMatchingUseCase
        let mbti: DefaultMBTIBoardUseCase
    }
    
    init(useCase: UseCase, container: DIContainer) {
        self.useCase = useCase
        self.container = container
    }

    func send(action: Action) {
        switch action {
        case .load:
            if !container.userStorage.profiles.isEmpty {
                // 멀티 프로필이 하나라도 존재한다면
                
                if container.userStorage.selectionProfile == nil {
                    // 프로필이 삭제되었다면
                    let random = container.userStorage.profiles.randomElement()
                    container.userStorage.selectionProfile = random
                    self.profile = random
                } else if container.userStorage.selectionProfile?.userCode != profile?.userCode {
                    // 유저코드가 변경되었다면
                    self.profile = container.userStorage.selectionProfile
                    fetchProfile()
                }
            } else {
                fetchProfile()
            }
        case .matching:
            guard let profile else { return }
            guard searchCodeText.count == 4 else { return }
            
            guard searchCodeText != profile.userCode else {
                self.send(action: .presentation(.easterEgg))
                return
            }
            
            let query = MatchingUserQuery(
                requestId: profile.userId,
                targetUserCode: searchCodeText
            )
            
            useCase.matching.execute(query: query)
                .sink { [weak self] completion in
                    guard let self else { return }
                    if case .failure = completion {
                        self.send(action: .alert(.failedMatchingProfile("프로필 조회에 실패했어요.")))
                    }
                    
                } receiveValue: { [weak self] matchingInfo in
                    guard let self else { return }
                    self.presentation = .matchResult(matchingInfo)
                    self.send(action: .saveMBTI(matchingInfo.profile.mbti))
                }.store(in: &cancellables)
            
        case let .saveMBTI(mbti):
            useCase.mbti.save(mbti: mbti)
            
        case .feedback:
            do {
                try container.openUrl.feedback()
            } catch let error {
                self.send(action: .alert(.failedFeedback(error.localizedDescription)))
            }
            
        case .appstore:
            do {
                try container.openUrl.appstore()
            } catch {
                
            }
            
        case .releaseNote:
            do {
                try container.openUrl.releaseNote()
            } catch {
                
            }
            
        case .update:
            
            break
            
        case let .presentation(presentation):
            self.presentation = presentation
            
        case let .alert(type):
            showsAlert = true
            alertMessage = type
            
        }
    }
    
    private func fetchProfile() {
        let query: FetchUserQuery = .init(id: container.userStorage.selectionProfile?.userId ?? "")
        useCase.fetchProfile.fetchProfileFromId(query: query)
            .sink { _ in

            } receiveValue: { [weak self] profile in
                guard let self else { return }
                self.profile = profile
            }.store(in: &cancellables)
    }
}

extension HomeViewModel: ProfileViewDelegate {
    func delete(profile: Profile) {
        self.send(action: .load)
    }
}
