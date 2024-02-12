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
        
        enum PresentationAction: Int, Identifiable, Equatable {
            var id: Int { self.rawValue }
            
            case home
        }
    }
    
    let applicationUseCase: ApplicationUseCase = .init(userStorage: .shared)
    let createProfileUseCase: CreateProfileUseCase = .init()
    
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
                self.applicationUseCase.hasProfile = true
                switch result {
                case .success(let profile):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.state.profile = profile
                        self.applicationUseCase.hasProfile = true
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
}

struct ProfileEditorView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @State var profile: Profile = .emptyValue
    @StateObject var viewModel = ProfileEditorViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Spacer()
                        .frame(height: 8)
                    
                    Text("프로필 만들기")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text("프로필을 바탕으로 매칭을 도와드려요")
                        .font(.system(size: 14))
                    
                    Spacer()
                        .frame(height: 24)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ProfileInputRow(type: .닉네임, profile: $viewModel.state.profile)
                        ProfileInputRow(type: .직군, profile: $viewModel.state.profile)
                        ProfileInputRow(type: .동아리, profile: $viewModel.state.profile)
                        ProfileInputRow(type: .MBTI, profile: $viewModel.state.profile)
                        ProfileInputRow(type: .생일, profile: $viewModel.state.profile)
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
                    /* action */
                } label: {
                    Text("피드백 보내기")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var matchingButtonView: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 16)
            
            Button {
                viewModel.send(action: .makeProfile)
            } label: {
                Text("이제 매칭할래요!")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .frame(height: 32)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.funch)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .frame(height: 114)
        .background(Color.gray)
    }
}

#Preview {
    NavigationStack {
        ProfileEditorView()
    }
}
