//
//  DIContainer.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import Foundation

protocol DependencyType {
    var services: ServiceType { get set }
}

final class DIContainer: DependencyType, ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
