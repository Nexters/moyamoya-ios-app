//
//  ProfileRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import UIKit
import Moya

enum ProfileRepositoryError: Error {
    case decodingFailure
    case unknown
}

/// `User 본인`을 기준으로 하는 repository
final class ProfileRepository: ProfileRepositoryType {
    private let provider: MoyaProvider<DefaultTargetType>
    
    init() {
        provider = MoyaProvider<DefaultTargetType>()
    }
    
    /// `내 프로필` 디바이스 기반 정보 조회
    func fetchProfile(completion: @escaping (Result<Profile, ProfileRepositoryError>) -> Void) {
        provider.request(.getUserProfileFromDeviceId(id: UIDevice.uuidString)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(ResponseDTO.GetProfile.self, from: response.data)
                    completion(.success(data.toDomain()))
                } catch {
                    completion(.failure(.decodingFailure))
                }
            case .failure(_):
                completion(.failure(.unknown))
            }
        }
    }
    
    /// `내 프로필` 생성
    func createProfile(
        createUserQuery: CreateUserQuery,
        completion: @escaping (Result<Profile, ProfileRepositoryError>) -> Void
    ) {
        let requestDTO = RequestDTO.CreateUserProfileDTO(query: createUserQuery)
        provider.request(.createUserProfile(parameters: requestDTO.toDitionary)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(ResponseDTO.CreateProfile.self, from: response.data)
                    completion(.success(data.toDomain()))
                } catch {
                    completion(.failure(.decodingFailure))
                }
            case .failure(_):
                completion(.failure(.unknown))
            }
        }
    }
}
