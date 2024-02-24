//
//  MatchUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/24/24.
//

import Foundation
import Combine

protocol MatchingUseCase {
    func execute(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError>
}

final class DefaultMatchingUseCase: MatchingUseCase {
    private let repository: MatchingRepository
    
    init() {
        self.repository = MatchingRepositoryImpl()
    }
    
    func execute(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError> {
        repository.matchingUser(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
