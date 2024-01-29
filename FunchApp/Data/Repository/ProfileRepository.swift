//
//  ProfileRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import UIKit
import Moya

/// `User 본인`을 기준으로 하는 repository
final class ProfileRepository: ProfileRepositoryType {
    private let provider: MoyaProvider<DefaultTargetType>
    
    init() {
        provider = MoyaProvider<DefaultTargetType>()
    }
    
    /// `내 프로필` 정보 조회
    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        provider.request(.getUserProfile(id: UIDevice.uuidString)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(ResponseDTO.GetProfileDTO.self, from: response.data)
                completion(.success(data!.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// `내 프로필` 생성
    func createProfile(
        createUserQuery: CreateUserQuery,
        completion: @escaping (Result<Profile, Error>) -> Void
    ) {
        let requestDTO = RequestDTO.CreateUserProfileDTO(query: createUserQuery)
        provider.request(.createUserProfile(parameters: requestDTO.toDitionary)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(ResponseDTO.CreateProfileDTO.self, from: response.data)
                completion(.success(data!.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
