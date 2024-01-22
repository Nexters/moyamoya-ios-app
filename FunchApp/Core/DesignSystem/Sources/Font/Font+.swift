//
//  Font+.swift
//  FunchApp
//
//  Created by 이성민 on 1/23/24.
//

import SwiftUI

enum SpoqaHanSans {
    static let bold = "SpoqaHanSansNeo-Bold.otf"
    static let medium = "SpoqaHanSansNeo-Medium.otf"
    static let regular = "SpoqaHanSansNeo-Regular.otf"
}

extension Font {
    
    enum Funch {
        /// weight: bold, size: 22
        static let title1: Font = .custom(SpoqaHanSans.bold, size: 22)
        /// weight: bold, size: 20
        static let title2: Font = .custom(SpoqaHanSans.bold, size: 20)
        /// weight: medium, size: 18
        static let subtitle1: Font = .custom(SpoqaHanSans.medium, size: 18)
        /// weight: medium, size: 16
        static let subtitle2: Font = .custom(SpoqaHanSans.medium, size: 16)
        /// weight: regular, size: 14
        static let body: Font = .custom(SpoqaHanSans.regular, size: 14)
        /// weight: regular, size: 12
        static let caption: Font = .custom(SpoqaHanSans.regular, size: 12)
    }
    
}
