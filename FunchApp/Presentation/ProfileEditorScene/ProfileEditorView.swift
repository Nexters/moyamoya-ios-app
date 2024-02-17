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
        case dropDownShouldBecomeFirstResponder(Bool)
        case keyboardShouldBecomeFirstResponder(Bool)
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
    @Published var subwaySearchText: String = ""
    @Published var keyboardIsFirstResponder: Bool = false
    @Published var dropDownIsFirstResponder: Bool = false
    
    struct State: Equatable {
        var userNickname: String = ""
        var majors: [Profile.Major] = []
        var clubs: [Profile.Club] = []
        var mbti: [String] = .init(repeating: "", count: 4)
        var bloodType: String = "A"
        var searchedSubwayInfo: [SubwayInfo] = []
        var subwayInfo: [SubwayInfo] = []
        var isEnabled: Bool = false
        
        enum PresentationState: Int, Identifiable, Equatable {
            var id: Int { self.rawValue }
            
            case home
        }
    }
    
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
        case .dropDownShouldBecomeFirstResponder(let isFirstResponder):
            dropDownIsFirstResponder = isFirstResponder
            
        case .keyboardShouldBecomeFirstResponder(let isFirstResponder):
            keyboardIsFirstResponder = isFirstResponder
            
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
                send(action: .keyboardShouldBecomeFirstResponder(false))
                state.majors = [major]
                
            case .clubs(let club):
                send(action: .keyboardShouldBecomeFirstResponder(false))
                if let index = state.clubs.firstIndex(of: club) {
                    state.clubs.remove(at: index)
                } else {
                    state.clubs.append(club)
                }
                
            case .mbti(let selection):
                send(action: .keyboardShouldBecomeFirstResponder(false))
                state.mbti[selection[0]] = Profile.mbtiPair[selection[0]][selection[1]]
                
            case .bloodType(let selectedType):
                send(action: .keyboardShouldBecomeFirstResponder(false))
                state.bloodType = selectedType
                
            case .subway(let subway):
                send(action: .keyboardShouldBecomeFirstResponder(false))
                state.subwayInfo = [subway]
                subwaySearchText = subway.name
                
            }
        
        case .subwaySearch:
            let query = SearchSubwayStationQuery(searchText: subwaySearchText)
            createProfileUseCase.searchSubway(query: query) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let subwayInfos):
                    self.state.searchedSubwayInfo = subwayInfos
                case .failure(_):
                    self.state.searchedSubwayInfo = []
                }
            }
            
        case .makeProfile:
            let query = makeCreateUserQuery()
            createProfileUseCase.createProfile(createUserQuery: query) { [weak self] result in
                switch result {
                case .success(let profile):
                    guard let self else { return }
                    self.applicationUseCase.hasProfile = true
                    self.applicationUseCase.profiles.append(profile)
                    self.presentation = .home
                    
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
                
                Spacer()
                    .frame(height: 0)
                    .keyboardBottomPadding(defaultHeight: UIDevice.current.hasNotch ? 114 : 96)
            }
            
            VStack(spacing: 0) {
                Spacer()
                matchingButtonView
            }
        }
        .onTapGesture {
            viewModel.send(action: .keyboardShouldBecomeFirstResponder(false))
            viewModel.send(action: .dropDownShouldBecomeFirstResponder(false))
        }
        .onReceive(viewModel.$keyboardIsFirstResponder) { keyboardIsFirstResponder in
            guard !keyboardIsFirstResponder else { return }
            hideKeyboard()
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    appCoordinator.paths.removeLast()
                } label: {
                    Image(.iconArrowBack)
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
        .toolbarBackground(Color.gray900, for: .navigationBar)
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


extension ProfileEditorView {
    
    private func profileInputRow(
        type: String,
        labelHeight: CGFloat,
        inputField: some View
    ) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(type)
                .foregroundStyle(.gray300)
                .customFont(.body)
                .frame(width: 52, height: 56, alignment: .leading)
            
            inputField
        }
    }
    
    
    var profileInputFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            profileInputRow(type: "닉네임", labelHeight: 56, inputField: userNicknameInputField)
            
            Spacer()
                .frame(height: 36)
            
            VStack(alignment: .leading, spacing: 16) {
                profileInputRow(type: "직군", labelHeight: 52, inputField: majorInputField)
                profileInputRow(type: "동아리", labelHeight: 52, inputField: clubsInputField)
                profileInputRow(type: "MBTI", labelHeight: 52, inputField: mbtiInputField)
                profileInputRow(type: "혈액형", labelHeight: 56, inputField: bloodTypeInputField)
                profileInputRow(type: "지하철", labelHeight: 56, inputField: subwayInputField)
            }
        }
        .padding(.vertical, 24)
    }
    
    
    private var userNicknameInputField: some View {
        FunchTextField(
            text: $viewModel.state.userNickname,
            placeholderText: "최대 9글자",
            textLimit: 9
        )
    }
    
    
    private var majorInputField: some View {
        DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Major.dummies, id: \.self) { major in
                ChipButton(
                    action: {
                        viewModel.send(action: .inputProfile(.major(major)))
                    },
                    title: major.name,
                    imageName: major.imageName,
                    isSelected: viewModel.state.majors.contains(major)
                )
            }
        }
    }
    
    
    private var clubsInputField: some View {
        DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Club.dummies, id: \.self) { club in
                ChipButton(
                    action: {
                        viewModel.send(action: .inputProfile(.clubs(club)))
                    },
                    title: club.name,
                    imageName: club.imageName,
                    isSelected: viewModel.state.clubs.contains(club)
                )
            }
        }
    }
    
    
    private var mbtiInputField: some View {
        HStack(alignment: .top, spacing: 8){
            ForEach(0..<4, id: \.self) { pairIndex in
                VStack(spacing: 0) {
                    ForEach(0..<2, id: \.self) { letterIndex in
                        ChipButton(
                            action: {
                                viewModel.send(action: .inputProfile(.mbti([pairIndex, letterIndex])))
                            },
                            title: Profile.mbtiPair[pairIndex][letterIndex],
                            isSelected: viewModel.state.mbti.contains(Profile.mbtiPair[pairIndex][letterIndex])
                        )
                    }
                }
                .background(.gray800)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    
    @ViewBuilder
    private var bloodTypeInputField: some View {
        let bloodTypes: [String] = ["A", "B", "AB", "O"]
        
        Menu {
            ForEach(bloodTypes, id: \.self) { bloodType in
                Button {
                    viewModel.send(action: .inputProfile(.bloodType(bloodType)))
                    viewModel.send(action: .dropDownShouldBecomeFirstResponder(false))
                } label: {
                    Text(bloodType)
                }
            }
        } label: {
            HStack(spacing: 0) {
                Text(viewModel.state.bloodType + "형")
                    .font(.Funch.body)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
        }
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            if viewModel.dropDownIsFirstResponder {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white, lineWidth: 1)
            }
        }
        .onTapGesture {
            viewModel.send(action: .dropDownShouldBecomeFirstResponder(true))
        }
    }
    
    
    private var subwayInputField: some View {
        VStack(spacing: 0) {
            FunchTextField(
                text: $viewModel.subwaySearchText,
                placeholderText: "가까운 지하철역 검색",
                leadingImage: .init(systemName: "magnifyingglass"),
                onSubmit: {
                    viewModel.send(action: .subwaySearch)
                }
            )
            
            Spacer()
                .frame(height: 4)
            
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    ForEach(viewModel.state.searchedSubwayInfo, id: \.self) { subwayInfo in
                        Button {
                            viewModel.send(action: .inputProfile(.subway(subwayInfo)))
                        } label: {
                            Text(subwayInfo.name.applyColorToText(target: viewModel.subwaySearchText, color: .white) ?? AttributedString(subwayInfo.name))
                                .font(.Funch.body)
                                .foregroundStyle(.gray500)
                        }
                        .padding(8)
                        .background(.gray800)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                    Spacer()
                }
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        ProfileEditorView()
    }
}

