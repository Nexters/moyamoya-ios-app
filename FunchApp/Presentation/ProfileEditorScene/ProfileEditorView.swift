//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

@MainActor
final class ProfileEditorViewModel: ObservableObject {
    
    @Published var state = State()
    @Published var presentation: State.PresentationState?
    
    struct State {
        var profile: Profile = .emptyValue
        var isEnabled: Bool = false
        
        enum PresentationState: Int, Identifiable, Equatable {
            var id: Int { self.rawValue }
            
            case home
        }
    }
    
    enum Action: Equatable {
        case onChangeProfile
        case makeProfile
        case feedback
        
        enum PresentationAction: Int, Identifiable, Equatable {
            var id: Int { self.rawValue }
            
            case home
        }
    }
    
    let applicationUseCase: ApplicationUseCase = .init(userStorage: .shared)
    let createProfileUseCase: CreateProfileUseCase = .init()
    let openURL: OpenURL = .init()
    
    func send(action: Action) {
        switch action {
        case .onChangeProfile:
            if !(state.profile.userNickname.isEmpty
                 || state.profile.majors.isEmpty
                 || state.profile.clubs.isEmpty
                 || state.profile.mbti.count < 4
                 || state.profile.bloodType.isEmpty
                 || state.profile.subwayInfos.isEmpty) {
                state.isEnabled = true
            } else {
                state.isEnabled = false
            }
        case .makeProfile:
            let majorName = state.profile.majors.map { major in
                switch major.name {
                case "개발자": return "developer"
                case "디자이너": return "designer"
                default: return "unknown"
                }
            }.first ?? "unknown"
            let clubNames = state.profile.clubs.map { club in
                switch club.name {
                case "넥스터즈": return "nexters"
                case "SOPT": return "sopt"
                case "Depromeet": return "depromeet"
                default: return "unknown"
                }
            }
            let bloodType = String(state.profile.bloodType.first ?? "X")
            let subwayInfoNames = state.profile.subwayInfos.map { $0.name }
            
            let query = CreateUserQuery(name: state.profile.userNickname,
                                        major: majorName,
                                        clubs: clubNames,
                                        bloodType: bloodType,
                                        subwayStationName: subwayInfoNames,
                                        mbti: state.profile.mbti)
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
                        
                        Spacer()
                            .frame(height: 24)
                        
                        profileInputRows
                        
                        Spacer()
                            .frame(height: 24)
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
        .onChange(of: viewModel.state.profile) { _, _ in
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
    
    private var profileInputRows: some View {
        VStack(alignment: .leading, spacing: 0) {
            ProfileInputRow(type: .닉네임, profile: $viewModel.state.profile)
            Spacer().frame(height: 36)
            ProfileInputRow(type: .직군, profile: $viewModel.state.profile)
            Spacer().frame(height: 16)
            ProfileInputRow(type: .동아리, profile: $viewModel.state.profile)
            Spacer().frame(height: 16)
            ProfileInputRow(type: .MBTI, profile: $viewModel.state.profile)
            Spacer().frame(height: 16)
            ProfileInputRow(type: .혈액형, profile: $viewModel.state.profile)
            Spacer().frame(height: 16)
            ProfileInputRow(type: .지하철, profile: $viewModel.state.profile) { text in
                /* action */
            }
        }
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
