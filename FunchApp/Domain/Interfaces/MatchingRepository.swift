//
//  MatchingRepositoryType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Combine
import Moya

protocol MatchingRepository {
    func matchingUser(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError>
}
