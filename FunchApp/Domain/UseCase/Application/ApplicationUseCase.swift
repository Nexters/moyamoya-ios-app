//
//  ApplicationUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import Foundation

protocol ApplicationUseCaseType {
    var hasProfile: Bool { get set }
}

final class ApplicationUseCase: ApplicationUseCaseType {
    private let userStorage: UserDefaultStorage
    
    init(userStorage: UserDefaultStorage) {
        self.userStorage = userStorage
    }
    
    var hasProfile: Bool {
        get { userStorage.hasProfile }
        set { userStorage.hasProfile = newValue }
    }
    
    var profiles: [Profile] {
        get { userStorage.profiles }
        set { userStorage.profiles = newValue }
    }
}
