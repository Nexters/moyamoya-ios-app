//
//  ToolbarFeature.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import UIKit

protocol OpenURLServiceType {
    func execute(type: OpenURLType)
}

final class OpenURLService: OpenURLServiceType {
    func execute(type: OpenURLType) {
        guard let url = URL(string: type.rawValue) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

enum OpenURLType: String {
    case feedback = "https://docs.google.com/forms/d/e/1FAIpQLSeA-PMJNkLe2mENodWYuPASMaLUBZk_4LSV9MfzyZCHxvBNzw/viewform"
    case appstore = "https://apps.apple.com/kr/app/%ED%99%A9%EA%B8%88%ED%8E%80%EC%B9%98/id6478166971"
    case releaseNote = "https://github.com/Nexters/moyamoya-ios-app/releases"
}
