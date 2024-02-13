//
//  ProfileView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    let profile: Profile = .testableValue
    
    private let openURL: OpenURLFeature = .init()
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(profile.userCode)
                        .font(.Funch.body)
                        .foregroundStyle(.gray400)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text(profile.userNickname)
                        .font(.Funch.title2)
                        .foregroundStyle(.white)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    profileView(profile)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .background(.gray800)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 24)
                
                Spacer()
            }
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
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
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
            ProfileChipRow(.직군, profile, isHighlighted: true)
            ProfileChipRow(.동아리, profile, isHighlighted: false)
            ProfileChipRow(.MBTI, profile, isHighlighted: false)
            ProfileChipRow(.혈액형, profile, isHighlighted: true)
            ProfileChipRow(.지하철, profile, isHighlighted: false)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
