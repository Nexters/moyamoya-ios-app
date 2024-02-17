//
//  SplashViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct SplashViewBuilder {
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        SplashView()
    }
}

