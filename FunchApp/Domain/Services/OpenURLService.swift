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
    case appstore = "앱스토어 링크"
}
