//
//  Text+.swift
//  FunchApp
//
//  Created by 이성민 on 1/23/24.
//

import SwiftUI

extension Text {
    /// kerning 및 line height를 적용하기 위한 Text extension
    ///
    /// - Parameters:
    ///     - text: 내부에 들어갈 텍스트입니다.
    ///     - font: 사용할 폰트입니다.
    ///
    /// - 필요한 공간은 font의 size와 font의 lineHeight의 곱이고,
    /// 계산된 값의 절반을 기존 Text 사이즈의 .vertical 방향으로 padding을 넣어줍니다
    /// - [kerning Reference](``https://developer.apple.com/documentation/swiftui/text/kerning(_:)``)
    /// - [line height Reference](``https://youngtomaturity.medium.com/ios-line-spacing-line-height-e11b51cfadd3``)
    func customFont(_ font: Font.FunchDesign) -> some View {
        self
            .font(font.value)
            .kerning(font.size * (font.kerning / 100))
            .padding(.vertical, font.size * (font.lineHeight - 1) / 2)
    }
}
