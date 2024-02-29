//
//  EasterEggViewModel.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

final class EasterEggViewModel: ObservableObject {
    
    private(set) var inject = Inject()
    
    struct Inject {
        var openUrl = OpenURLImplement.shared
    }
    
    init() { }
}
