//
//  SplashViewBuilder.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import SwiftUI

struct SplashViewBuilder: Buildable {
    var container: DependencyType
    
    init(container: DependencyType) {
        self.container = container
    }
    
    var body: some View {
        SplashView()
    }
}

