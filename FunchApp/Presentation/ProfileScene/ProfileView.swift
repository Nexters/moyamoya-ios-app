//
//  ProfileView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    @Published var state: State = .init()
    
    struct State {
        var profile: Profile = .emptyValue
    }
    
    enum Action {
        case fetchProfile
        case feedback
    }
    
    let applicationUseCase: ApplicationUseCase = .init(userStorage: .shared)
    let openURL: OpenURL = .init()
    
    func send(action: Action) {
        switch action {
        case .fetchProfile:
            state.profile = applicationUseCase.profiles.last ?? .emptyValue
        case .feedback:
            openURL.execute(type: .feedback)
        }
    }
}

struct ProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ProfileViewModel()
    
    private let openURL: OpenURL = .init()
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.state.profile.userCode)
                        .font(.Funch.body)
                        .foregroundStyle(.gray400)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text(viewModel.state.profile.userNickname)
                        .font(.Funch.title2)
                        .foregroundStyle(.white)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    profileView(viewModel.state.profile)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .background(.gray800)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.send(action: .fetchProfile)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    openURL.execute(type: .feedback)
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
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.dismiss()
                } label: {
                    Image(.iconX)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func profileView(_ profile: Profile) -> some View {
        let major: String = profile.majors.map { $0.name }.first ?? ""
        let clubs: [String] = profile.clubs.map { $0.name }
        let subwayInfos: [String] = profile.subwayInfos.map { $0.name }
        
        let profile: ProfileChipRow.ProfileRowInfo = .init(major: major,
                                                           clubs: clubs,
                                                           mbti: profile.mbti,
                                                           bloodType: profile.bloodType,
                                                           subwayInfos: subwayInfos)
        
        VStack(alignment: .leading, spacing: 16) {
            ProfileChipRow(.직군, profile)
            ProfileChipRow(.동아리, profile)
            ProfileChipRow(.MBTI, profile)
            ProfileChipRow(.혈액형, profile)
            ProfileChipRow(.지하철, profile)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
