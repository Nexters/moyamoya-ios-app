//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

final class ProfileEditorViewModel: ObservableObject {
    
    @Published var state = State()
    @Published var presentation: State.PresentationState?
    
    struct State {
        var profile: Profile = .emptyValue
        
        enum PresentationState: Int, Identifiable, Equatable {
            var id: Int { self.rawValue }
            
            case home
        }
    }
    
    enum Action: Equatable {
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
        case .makeProfile:
            let clubNames = state.profile.clubs.map { $0.name }
            let subwayInfoNames = state.profile.subwayInfos.map { $0.name }
            let majorName = state.profile.majors.map { $0.name }.first ?? "unknown"
            
            let query = CreateUserQuery(name: state.profile.userNickname,
                                        birth: state.profile.birth,
                                        major: majorName,
                                        clubs: clubNames,
                                        subwayStationName: subwayInfoNames,
                                        mbti: state.profile.mbti)
            createProfileUseCase.createProfile(createUserQuery: query) { result in
                switch result {
                case .success(let profile):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.applicationUseCase.hasProfile = true
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
    @State private var buttonIsEnabled: Bool = false
    @State var profile: Profile = .emptyValue
    
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
                        
                        VStack(alignment: .leading, spacing: 16) {
                            ProfileInputRow(type: .닉네임, profile: $viewModel.state.profile)
                            ProfileInputRow(type: .직군, profile: $viewModel.state.profile)
                            ProfileInputRow(type: .동아리, profile: $viewModel.state.profile)
                            ProfileInputRow(type: .MBTI, profile: $viewModel.state.profile)
                            ProfileInputRow(type: .혈액형, profile: $viewModel.state.profile)
                            ProfileInputRow(type: .지하철, profile: $viewModel.state.profile)
                        }
                        
                        Spacer()
                            .frame(height: 24)
                    }
                    .padding(.horizontal, 20)
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                matchingButtonView
            }
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
    
    private var matchingButtonView: some View {
        VStack(spacing: 0) {
            
            Button {
                viewModel.send(action: .makeProfile)
            } label: {
                Text("이제 매칭할래요!")
                    .foregroundStyle(.gray900)
                    .customFont(.subtitle1)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(DefaultFunchButtonStyle(isEnabled: buttonIsEnabled))
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(.gray900)
    }
}

#Preview {
    NavigationStack {
        ProfileEditorView()
    }
}
