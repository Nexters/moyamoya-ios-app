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
    
    private var inject: DIContainer.Inject
    
    init(inject: DIContainer.Inject) {
        self.inject = inject
    }

    func send(action: Action) {
        switch action {
        case .feedback:
            do {
                try inject.openUrl.feedback()
            } catch { }
        }
    }
}
