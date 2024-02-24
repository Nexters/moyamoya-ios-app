//
//  MatchingRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Moya
import SwiftUI
import Combine

final class MatchingRepositoryImpl: MatchingRepository {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    func matchingUser(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError> {
        let requestDTO = RequestDTO.MatchingUser(query: query)
        return Future { [weak self] promise in
            guard let self else { return }
            self.apiClient.request(
                ResponseDTO.MatchingUser.self,
                target: .matchingUser(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(let failure):
//                    promise(.failure(failure))
                    break
                }
            }
        }.eraseToAnyPublisher()
    }

}
