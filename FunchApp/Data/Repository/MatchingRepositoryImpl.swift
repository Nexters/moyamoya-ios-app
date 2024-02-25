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
        apiClient = APIClient.shared
    }
    
    func matchingUser(query: MatchingUserQuery) -> AnyPublisher<MatchingInfo, RepositoryError> {
        return Future { [weak self] promise in
            guard let self else { return }
            let requestDTO = RequestDTO.MatchingUser(query: query)
            self.apiClient.request(
                ResponseDTO.MatchingUser.self,
                target: .matchingUser(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
                    promise(.failure(.message("프로필 조회에 실패했어요.")))
                }
            }
        }.eraseToAnyPublisher()
    }

}
