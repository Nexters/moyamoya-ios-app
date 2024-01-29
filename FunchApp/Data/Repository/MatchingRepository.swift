//
//  MatchingRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation
import Moya

/// `User 타인`을 기준으로 하는 repository
final class MatchingRepository: MatchingRepositoryType {
    private let provider: MoyaProvider<DefaultTargetType>
    
    init() {
        provider = MoyaProvider<DefaultTargetType>()
    }
    
    /// `상대 프로필` 검색
    func searchUser(
        searchUserQuery: SearchUserQuery,
        completion: @escaping (Result<Profile, Error>) -> Void
    ) {
        let requestDTO = RequestDTO.MatchingUser(query: searchUserQuery)
        provider.request(.matchingUser(parameters: requestDTO.toDitionary)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(ResponseDTO.GetProfileDTO.self, from: response.data)
                completion(.success(data!.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
