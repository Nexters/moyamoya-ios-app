//
//  ApplicationUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/12/24.
//

import Foundation

protocol UserServiceType {
    var profiles: [Profile] { get set }
    var matchedResults: [MatchingInfo] { get set }
    var bingoMBTIBoard: [String: Int] { get set }
}

final class UserService: UserServiceType {
    private let userStorage: UserDefaultStorage
    
    init() {
        self.userStorage = .shared
    }
    
    var profiles: [Profile] {
        get { userStorage.profiles }
        set { userStorage.profiles = newValue }
    }
    
    var matchedResults: [MatchingInfo] {
        get { userStorage.matchedResults }
        set { userStorage.matchedResults = newValue }
    }
    
    var bingoMBTIBoard: [String: Int] {
        get { userStorage.bingoMBTIBoard ?? [:] }
        set { userStorage.bingoMBTIBoard = newValue }
    }
}
