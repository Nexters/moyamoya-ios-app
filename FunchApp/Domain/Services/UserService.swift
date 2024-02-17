//
//  ApplicationUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import Foundation

protocol UserServiceType {
    var profiles: [Profile] { get set }
}

final class UserService: UserServiceType {
    private let userStorage: UserDefaultStorage
    
    init(userStorage: UserDefaultStorage) {
        self.userStorage = userStorage
    }
    
    var profiles: [Profile] {
        get { userStorage.profiles }
        set { userStorage.profiles = newValue }
    }
}
