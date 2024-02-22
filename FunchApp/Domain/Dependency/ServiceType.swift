//
//  ServiceType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/22/24.
//

import Foundation

protocol ServiceType {
    var openURLSerivce: OpenURLServiceType { get set }
    var userService: UserServiceType { get set }
}
