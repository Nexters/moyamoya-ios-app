//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI
import Combine

@MainActor
final class ProfileEditorViewModel: ObservableObject {
    
    enum Action: Equatable {
        case shouldBecomeFirstResign
        case onChangeProfile
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
    
    @Published var state = State()
    @Published var presentation: State.PresentationState?
    
    struct State: Equatable {
        var userNickname: String = ""
        var majors: [Profile.Major] = []
        var clubs: [Profile.Club] = []
        var mbti: [String] = .init(repeating: "", count: 4)
        var bloodType: String = ""
        var subwaySearchText: String = ""
        var searchedSubwayInfo: [SubwayInfo] = []
        var subwayInfo: [SubwayInfo] = []
        var isEnabled: Bool = false
        
        enum PresentationState: Int, Identifiable, Equatable {
            var id: Int { self.rawValue }
            
            case home
        }
    }
    
    @Published var shouldBecomeFirstResign: Bool = false
    @Published var subwaySearchText: String = ""
    init() {
        applicationUseCase = .init(userStorage: .shared)
        createProfileUseCase = .init()
        openURL = .init()
        
        bind()
    }

    private let applicationUseCase: ApplicationUseCase
    private let createProfileUseCase: CreateProfileUseCase
    private let openURL: OpenURL
    
    private var cancellables = Set<AnyCancellable>()
    
    private func bind() {
        $subwaySearchText
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                if text.isEmpty {
                    self.send(action: .shouldBecomeFirstResign)
                } else {
                    self.send(action: .subwaySearch)
                }
            }.store(in: &cancellables)
            
    }
    
    func send(action: Action) {
        switch action {
        case .shouldBecomeFirstResign:
            shouldBecomeFirstResign = true
            
        case .onChangeProfile:
            if !(
                state.userNickname.isEmpty
                || state.majors.isEmpty
                || state.clubs.isEmpty
                || state.mbti.count < 4
                || state.bloodType.isEmpty
                || state.subwayInfo.isEmpty
            ) {
                state.isEnabled = true
            } else {
                state.isEnabled = false
            }
            
        case let .inputProfile(type):
            switch type {
            case .nickname(let inputText):
                state.userNickname = inputText
                
            case .major(let major):
                state.majors = [major]
                
            case .clubs(let club):
                if let index = state.clubs.firstIndex(of: club) {
                    state.clubs.remove(at: index)
                } else {
                    state.clubs.append(club)
                }
                
            case .mbti(let selection):
                state.mbti[selection[0]] = Profile.mbtiPair[selection[0]][selection[1]]
                
            case .bloodType(let selectedType):
                state.bloodType = selectedType
                
            case .subway(let subway):
                state.subwayInfo = [subway]
                state.subwaySearchText = subway.name
                
            }
        
        case .subwaySearch:
            shouldBecomeFirstResign = true
            
            let query = SearchSubwayStationQuery(searchText: state.subwaySearchText)
            createProfileUseCase.searchSubway(query: query) { result in
                switch result {
                case .success(let subwayInfos):
                    self.state.searchedSubwayInfo = subwayInfos
                case .failure(_):
                    self.state.searchedSubwayInfo = []
                }
            }
            
        case .makeProfile:
            let query = makeCreateUserQuery()
            createProfileUseCase.createProfile(createUserQuery: query) { result in
                switch result {
                case .success(let profile):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.applicationUseCase.hasProfile = true
                        self.applicationUseCase.profiles.append(profile)
                        self.presentation = .home
                    }
                case .failure(_):
                    break
                }
            }
            
        case .feedback:
            openURL.execute(type: .feedback)
            
        }
    }
}

extension ProfileEditorViewModel {
    private func makeCreateUserQuery() -> CreateUserQuery {
        let major = state.majors.map { major in
            switch major.name {
            case "개발자": return "developer"
            case "디자이너": return "designer"
            default: return "unknown"
            }
        }.first ?? "unknown"
        let clubs = state.clubs.map { club in
            switch club.name {
            case "넥스터즈": return "nexters"
            case "SOPT": return "sopt"
            case "Depromeet": return "depromeet"
            default: return "unknown"
            }
        }
        let bloodType = state.bloodType
        let subwayInfoNames = state.subwayInfo.map { $0.name }
        let mbti = state.mbti.reduce("", { $0 + $1 })
        
        return CreateUserQuery(
            name: state.userNickname,
            major: major,
            clubs: clubs,
            bloodType: bloodType,
            subwayStationName: subwayInfoNames,
            mbti: mbti
        )
    }
}

struct ProfileEditorView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var viewModel = ProfileEditorViewModel()
    
    enum InputFields {
        case major, clubs, mbti
        case username
        case bloodType
        case subway
    }
    
    @FocusState var focused: InputFields?
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Spacer()
                            .frame(height: 8)
                        
                        Text("프로필 만들기")
                            .foregroundStyle(.white)
                            .customFont(.title2)
                        
                        Spacer()
                            .frame(height: 2)
                        
                        Text("프로필을 바탕으로 매칭을 도와드려요")
                            .foregroundStyle(.gray300)
                            .customFont(.body)
                        
                        profileInputFields
                    }
                    .padding(.horizontal, 20)
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                Spacer()
                    .frame(height: 0)
                    .keyboardBottomPadding(defaultHeight: UIDevice.current.hasNotch ? 114 : 96)
            }
            
            VStack(spacing: 0) {
                Spacer()
                matchingButtonView
            }
        }
        .onChange(of: viewModel.state) { _, _ in
            viewModel.send(action: .onChangeProfile)
        }
        .onReceive(viewModel.$presentation) {
            switch $0 {
            case .home:
                appCoordinator.paths.removeAll()
            default:
                break
            }
        }
        .onReceive(viewModel.$shouldBecomeFirstResign) { _ in
            Task { @MainActor in
                hideKeyboard()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    appCoordinator.paths.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.send(action: .feedback)
                } label: {
                    Text("피드백 보내기")
                        .foregroundStyle(.white)
                        .customFont(.body)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.gray800)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var matchingButtonView: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 16)
                
                Button {
                    viewModel.send(action: .makeProfile)
                } label: {
                    Text("이제 매칭할래요!")
                        .foregroundStyle(.gray900)
                        .customFont(.subtitle1)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultFunchButtonStyle(isEnabled: viewModel.state.isEnabled))
                .disabled(!viewModel.state.isEnabled)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
        .frame(height: UIDevice.current.hasNotch ? 114 : 96)
        .background(.gray900)
    }
}

#Preview {
    NavigationStack {
        ProfileEditorView()
    }
}
