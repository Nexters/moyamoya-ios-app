//
//  ChipViewHighlighter.swift
//  FunchApp
//
//  Created by 이성민 on 2/13/24.
//

import Foundation
import SwiftUI

extension View {
    func highlight(_ isHighlighted: Bool) -> some View {
        modifier(ChipViewHighlighter(isHighlighted: isHighlighted))
    }
}

struct ChipViewHighlighter: ViewModifier {
    /// highlight 여부
    private(set) var isHighlighted: Bool
    
    func body(content: Content) -> some View {
        if isHighlighted {
            content
                .shadow(color: .lemon500.opacity(0.5), radius: 2.5, x: 0, y: 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .inset(by: 0.5)
                        .stroke(Gradient.funchGradient(type: .lemon500), lineWidth: 1)
                )
        } else {
            content
        }
    }
}
