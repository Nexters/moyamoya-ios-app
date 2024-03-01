//
//  OnboardingView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("친구와 프로필 매칭하기")
                    .font(.Funch.body)
                    .foregroundColor(.gray300)
                
                Spacer()
                    .frame(height: 2)
                
                Text("우리 사이의 공통점을 찾아요")
                    .font(.Funch.title1)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 28)
                
                Image(.onboarding)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 76)
                
                Spacer()
                    .frame(height: 28)
                
                Text("1분만에 프로필 만들고 매칭해보기")
                    .font(.Funch.body)
                    .foregroundColor(.gray300)
                
                Spacer()
                    .frame(height: 8)
                
                Button {
                    appCoordinator.paths.append(.onboarding(.createProfile))
                } label: {
                    Text("프로필 생성 시작🚀")
                        .font(.Funch.subtitle2)
                        .foregroundColor(.gray900)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 172, height: 52)
                .background(Gradient.funchGradient(type: .lemon500))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .lemon500.opacity(0.7), radius: 4, x: 0, y: 4)
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    OnboardingView()
}
