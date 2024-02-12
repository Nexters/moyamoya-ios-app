//
//  ToolbarFeature.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import UIKit

final class OpenURLFeature {

    enum URLType: String {
        case feedback = "피드백 링크"
        case appstore = "앱스토어 링크"
    }
    
    func execute(type: URLType) {
        guard let url = URL(string: type.rawValue) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
