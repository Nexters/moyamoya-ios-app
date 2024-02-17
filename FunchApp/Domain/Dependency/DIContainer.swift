//
//  DIContainer.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import Foundation

final class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
