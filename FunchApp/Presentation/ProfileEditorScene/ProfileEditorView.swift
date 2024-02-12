//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileEditorView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @State var profile: Profile = .emptyValue
    
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
                        ProfileInputRow(type: .닉네임, profile: $profile)
                        ProfileInputRow(type: .직군, profile: $profile)
                        ProfileInputRow(type: .동아리, profile: $profile)
                        ProfileInputRow(type: .MBTI, profile: $profile)
                        ProfileInputRow(type: .생일, profile: $profile)
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
                /* action */
                appCoordinator.paths.removeAll()
                appCoordinator.hasProfile = true
                
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
