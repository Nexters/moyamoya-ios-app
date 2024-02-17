//
//  SplashView.swift
//  FunchApp
//
//  Created by 이성민 on 2/17/24.
//

import SwiftUI
import UIKit
import Lottie

struct SplashView: View {
    var body: some View {
        ZStack {
            Gradient.funchGradient(type: .black)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(.splashBgTop)
                        .resizable()
                        .frame(width: 375, height: 323)
                        .offset(x: -180)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    Image(.splashBgBottom)
                        .resizable()
                        .frame(width: 353, height: 303)
                        .offset(x: 135)
                }
            }
            LottieView(animation: .named("Funch_splash_background_ani"))
                .playing(loopMode: .playOnce)
            LottieView(animation: .named("Funch_splash_logo"))
                .playing(loopMode: .playOnce)
        }
    }
}

#Preview {
    SplashView()
}
