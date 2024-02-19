//
//  ProfileEditorViewModel.swift
//  FunchApp
//
//  Created by 이성민 on 2/19/24.
//

import Foundation
import SwiftUI
import Combine

final class ProfileEditorViewModel: ObservableObject {
    
    @Published var presentation: PresentationState?
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
    
    enum Action: Equatable {
        case onChangeProfile
        case focusField(InputField?)
        case inputProfile(InputType)
        case subwaySearch
        case makeProfile
        case feedback
        
        enum PresentationAction: Int, Identifiable, Equatable {
            var id: Int { self.rawValue }
            
            case home
        }
        
        enum InputType: Equatable {
            case nickname(String)
            case major(Profile.Major)
            case clubs(Profile.Club)
            case mbti([Int])
            case bloodType(String)
            case subway(SubwayInfo)
        }
    }
    
    enum PresentationState: Int, Identifiable, Equatable {
        var id: Int { self.rawValue }
        
        case home
    }
    
    enum InputField {
        case nickname, major, clubs, mbti, bloodType, subway
    }
    
    private var container: DependencyType
    private var useCase: CreateProfileUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DependencyType, useCase: CreateProfileUseCase) {
        self.container = container
        self.useCase = useCase
        
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
            useCase.searchSubway(query: query) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let subwayInfos):
                    self.searchedSubwayInfo = subwayInfos
                case .failure(_):
                    self.searchedSubwayInfo = []
                }
            }
            
        case .makeProfile:
            let query = makeCreateUserQuery()
            useCase.createProfile(createUserQuery: query) { [weak self] result in
                switch result {
                case .success(let profile):
                    guard let self else { return }
                    self.container.services.userService.profiles.append(profile)
                    self.presentation = .home
                    
                case .failure(_):
                    break
                }
            }
            
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
