//
//  SplashView.swift
//  FunchApp
//
//  Created by 이성민 on 2/17/24.
//

import Foundation
import SwiftUI
import UIKit

import Lottie

struct SplashView: View {
    var body: some View {
        ZStack {
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
