//
//  NoTapEffectButtonStyle.swift
//  FunchApp
//
//  Created by 이성민 on 1/21/24.
//

import SwiftUI

extension PrimitiveButtonStyle where Self == NoTapEffectButtonStyle {
    /// 아무 이펙트가 없는 버튼 스타일입니다
    static var noEffect: NoTapEffectButtonStyle { .init() }
}

/// 아무 이펙트가 없는 버튼 스타일입니다
struct NoTapEffectButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
