//
//  Services.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/17/24.
//

import Foundation

protocol ServiceType {
    var openURLSerivce: OpenURLServiceType { get set }
    var userService: UserServiceType { get set }
}

final class Services: ServiceType {
    var openURLSerivce: OpenURLServiceType
    var userService: UserServiceType
    
    init() {
        self.openURLSerivce = OpenURLService()
        self.userService = UserService(userStorage: .shared)
    }
}
