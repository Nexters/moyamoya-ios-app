//
//  EasterEggViewModel.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

final class EasterEggViewModel: ObservableObject {
    
    enum Action {
        case feedback
    }
    
    private(set) var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }

    func send(action: Action) {
        switch action {
        case .feedback:
            do {
                try container.openUrl.feedback()
            } catch { }
        }
    }
}
