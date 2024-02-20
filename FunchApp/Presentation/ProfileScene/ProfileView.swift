//
//  ProfileView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    if let profile = viewModel.profile {
                        profileView(profile)
                    } else {
                        Text("프로필을 불러오는 중이에요.")
                    }
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
            viewModel.send(action: .load)
        }
        .onReceive(viewModel.$dismiss) { boolean in
            if boolean {
                dismiss()
            }
        }
        .toolbar {
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
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(.iconX)
                        .foregroundColor(.gray400)
                }
            }
        }
    }
    
    
    private func profileView(_ profile: Profile) -> some View {
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
            
            VStack(alignment: .leading, spacing: 16) {
                profileRow("직군") {
                    ChipView(title: profile.majors[0].name,
                             imageName: profile.majors[0].imageName)
                }
                
                profileRow("동아리") {
                    DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
                        ForEach(profile.clubs, id: \.self) { club in
                            ChipView(title: club.name, imageName: club.imageName)
                        }
                    }
                }
                
                profileRow("MBTI") {
                    ChipView(title: profile.mbti)
                }
                
                profileRow("혈액형") {
                    ChipView(title: profile.bloodType + "형")
                }
                
                profileRow("지하철") {
                    SubwayChipView(subway: profile.subwayInfos[0])
                }
            }
        }
    }
    
    private func profileRow(_ label: String, row profileRow: () -> some View) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(label)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .font(.Funch.body)
                .foregroundStyle(.gray400)
                .frame(width: 52, height: 48, alignment: .leading)
            
            profileRow()
            
            Spacer()
        }
    }
}

#Preview {
    @StateObject var container = DIContainer(services: Services())
    return ProfileViewBuilder(container: container).body
}
