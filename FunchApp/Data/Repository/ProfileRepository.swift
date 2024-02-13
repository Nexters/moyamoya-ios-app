//
//  ProfileRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import UIKit
import Moya

/// User 본인을 기준으로 하는 repository
final class ProfileRepository: ProfileRepositoryType {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    /// 내 프로필 디바이스 기반 정보 조회
    func fetchProfile(completion: @escaping (Result<Profile, MoyaError>) -> Void) {
        var query: DictionaryType {
            [
                "deviceNumber": UIDevice.uuidString,
            ]
        }
        apiClient.request(
            ResponseDTO.GetProfile.self,
            target: .getUserProfileFromDeviceId(parameters: query)
        ) { result in
            switch result {
            case .success(let success):
                completion(.success(success.toDomain()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    /// 내 프로필 디바이스 기반 정보 조회
    func fetchProfileId(
        userQuery: FetchUserQuery,
        completion: @escaping (Result<Profile, MoyaError>) -> Void
    ) {
        apiClient.request(
            ResponseDTO.GetProfile.self,
            target: .getUserProfileFromId(path: userQuery.path)
        ) { result in
            switch result {
            case .success(let success):
                completion(.success(success.toDomain()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    /// 내 프로필 생성
    func createProfile(
        createUserQuery: CreateUserQuery,
        completion: @escaping (Result<Profile, MoyaError>) -> Void
    ) {
        let requestDTO = RequestDTO.CreateUserProfileDTO(query: createUserQuery)
        apiClient.request(
            ResponseDTO.CreateProfile.self,
            target: .createUserProfile(parameters: requestDTO.toDitionary)
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
