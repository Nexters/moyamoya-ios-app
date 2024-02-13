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
                    
                    VStack(spacing: 20) {
                        ProfileChipRow(.직군, .testableValue)
                        ProfileChipRow(.동아리, .testableValue)
                        ProfileChipRow(.MBTI, .testableValue)
                        ProfileChipRow(.혈액형, .testableValue)
                        ProfileChipRow(.지하철, .testableValue)
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    /* action */
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
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
