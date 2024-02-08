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
        VStack {
            Spacer()
                .frame(height: 8)
            VStack(alignment: .leading, spacing: 0) {
                Text(profile.userCode)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
                
                Spacer()
                    .frame(height: 2)
                
                Text(profile.userNickname)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.68, green: 0.68, blue: 0.68))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
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
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            .frame(width: 320, alignment: .center)
            .background(.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 1)
            )
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // action
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
