//
//  MatchingRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation
import Moya

/// User 타인을 기준으로 하는 repository
final class MatchingRepository: MatchingRepositoryType {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    /// 상대 프로필 검색
    func searchUser(
        searchUserQuery: MatchingUserQuery,
        completion: @escaping (Result<Profile, MoyaError>) -> Void
    ) {
        let requestDTO = RequestDTO.MatchingUser(query: searchUserQuery)
        apiClient.request(
            ResponseDTO.GetProfile.self,
            target: .matchingUser(parameters: requestDTO.toDitionary)
        ) { result in
            switch result {
            case .success(let success):
                completion(.success(success.toDomain()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
