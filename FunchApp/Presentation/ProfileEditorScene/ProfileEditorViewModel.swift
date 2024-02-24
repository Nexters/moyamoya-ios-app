//
//  ProfileEditorViewModel.swift
//  FunchApp
//
//  Created by 이성민 on 2/19/24.
//

import SwiftUI
import Combine

final class ProfileEditorViewModel: ObservableObject {
    
    enum Action: Equatable {
        case onChangeProfile
        case focusField(InputField?)
        case inputProfile(InputType)
        case subwaySearch
        case makeProfile
        case feedback
        
        enum InputType: Equatable {
            case nickname(String)
            case major(Profile.Major)
            case clubs(Profile.Club)
            case mbti([Int])
            case bloodType(String)
            case subway(SubwayInfo)
        }
    }
    
    enum InputField {
        case nickname, major, clubs, mbti, bloodType, subway
    }
    
    @Published var subwaySearchText: String = ""
    @Published var focusedField: InputField?
    
    @Published var userNickname: String = ""
    @Published var majors: [Profile.Major] = []
    @Published var clubs: [Profile.Club] = []
    @Published var mbti: [String] = .init(repeating: "", count: 4)
    @Published var bloodType: String = "A"
    @Published var searchedSubwayInfo: [SubwayInfo] = []
    @Published var subwayInfo: [SubwayInfo] = []
    @Published var isEnabled: Bool = false
    @Published var presentation: ProfileEditorPresentation?
    
    private var container: DependencyType
    private var useCase = UseCase()
    
    struct UseCase {
        var createProfile = DefaultCreateProfileUseCase()
        var searchSubway = DefaultSearchSubwayUseCase()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init(container: DependencyType) {
        self.container = container
        
        bind()
    }
    
    private func bind() {
        $subwaySearchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                if !text.isEmpty {
                    self.send(action: .subwaySearch)
                }
            }.store(in: &cancellables)
    }
    
    func send(action: Action) {
        switch action {
        case .focusField(let inputType):
            focusedField = inputType
            
        case .onChangeProfile:
            if !(
                userNickname.isEmpty
                || majors.isEmpty
                || clubs.isEmpty
                || mbti.count < 4
                || bloodType.isEmpty
                || subwayInfo.isEmpty
            ) {
                isEnabled = true
            } else {
                isEnabled = false
            }
            
        case let .inputProfile(type):
            switch type {
            case .nickname(_):
                break
                
            case .major(let major):
                majors = [major]
                send(action: .focusField(.major))
                
            case .clubs(let club):
                if let index = clubs.firstIndex(of: club) {
                    clubs.remove(at: index)
                } else {
                    clubs.append(club)
                }
                send(action: .focusField(.clubs))
                
            case .mbti(let selection):
                mbti[selection[0]] = Profile.mbtiPair[selection[0]][selection[1]]
                send(action: .focusField(.mbti))
                
            case .bloodType(let selectedType):
                bloodType = selectedType
                send(action: .focusField(.bloodType))
                
            case .subway(let subway):
                subwayInfo = [subway]
                subwaySearchText = subway.name
            }
            
            send(action: .onChangeProfile)
        
        case .subwaySearch:
            let query = SearchSubwayStationQuery(searchText: subwaySearchText)
            useCase.searchSubway.execute(query: query)
                .sink { [weak self] completion in
                    guard let self else { return }
                    if case .failure = completion {
                        self.searchedSubwayInfo = []
                    }
                } receiveValue: { [weak self] subwayInfos in
                    guard let self else { return }
                    self.searchedSubwayInfo = subwayInfos
                }.store(in: &cancellables)
            
        case .makeProfile:
            let query = makeCreateUserQuery()
            useCase.createProfile.createProfile(query: query)
                .sink { _ in
                    
                } receiveValue: { [weak self] profile in
                    guard let self else { return }
                    self.container.services.userService.profiles.append(profile)
                    self.presentation = .home
                }.store(in: &cancellables)
            
        case .feedback:
            container.services.openURLSerivce.execute(type: .feedback)
            
        }
    }
}


extension ProfileEditorViewModel {
    private func makeCreateUserQuery() -> CreateUserQuery {
        let major = majors.map { major in
            switch major.name {
            case "개발자": return "developer"
            case "디자이너": return "designer"
            default: return "unknown"
            }
        }.first ?? "unknown"
        let clubs = clubs.map { club in
            switch club.name {
            case "넥스터즈": return "nexters"
            case "SOPT": return "sopt"
            case "Depromeet": return "depromeet"
            default: return "unknown"
            }
        }
        let bloodType = bloodType
        let subwayInfoNames = subwayInfo.map { $0.name }
        let mbti = mbti.reduce("", { $0 + $1 })
        
        return CreateUserQuery(
            name: userNickname,
            major: major,
            clubs: clubs,
            bloodType: bloodType,
            subwayStationName: subwayInfoNames,
            mbti: mbti
        )
    }
}
