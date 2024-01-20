//
//  DefaultFunchButtonStyle.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

extension ButtonStyle where Self == DefaultFunchButtonStyle {
    /// 앱 내에서 사용하는 기본 펀치 스타일
    static var funch: DefaultFunchButtonStyle {
        DefaultFunchButtonStyle()
    }
}

/// 우리 앱에서 사용하는  `기본` 버튼 스타일
struct DefaultFunchButtonStyle: ButtonStyle {
    /// 버튼 클릭 여부에 따른 fade 여부
    var fadeOnPress = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(.black)
            .opacity(configuration.isPressed && fadeOnPress ? 0.75 : 1)
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
