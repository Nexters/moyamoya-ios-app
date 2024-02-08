//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileEditorView: View {
    
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
                            ProfileInputRow(type: .닉네임, profile: $profile)
                            ProfileInputRow(type: .직군, profile: $profile)
                            ProfileInputRow(type: .동아리, profile: $profile)
                            ProfileInputRow(type: .MBTI, profile: $profile)
                            ProfileInputRow(type: .혈액형, profile: $profile)
                            ProfileInputRow(type: .지하철, profile: $profile)
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
            }
            
        }
    }
    
    
    private var matchingButtonView: some View {
        VStack(spacing: 0) {
            
            Button {
                /* action */
                buttonIsEnabled.toggle()
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
