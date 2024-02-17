//
//  MatchingRepositoryType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation
import Moya

protocol MatchingRepositoryType {
    func matchingUser(
        searchUserQuery: MatchingUserQuery,
        completion: @escaping (Result<MatchingInfo, MoyaError>) -> Void
    )
}
