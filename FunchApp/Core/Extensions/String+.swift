//
//  String+.swift
//  FunchApp
//
//  Created by 이성민 on 2/6/24.
//

import SwiftUI

extension String {
    func applyColorToText(target: String, color: Color) -> AttributedString? {
        var attributedString = AttributedString(self)
        guard let range = attributedString.range(of: target) else { return nil }
        attributedString[range].foregroundColor = color
        return attributedString
    }
}
