//
//  ProfileRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import UIKit
import Moya
import SwiftUI
import Combine

enum RepositoryError: Error {
    case message(String)
}

/// User 본인을 기준으로 하는 repository
final class ProfileRepositoryImpl: ProfileRepository {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    /// 내 프로필 디바이스 기반 정보 조회
    func fetchProfile() -> AnyPublisher<Profile, RepositoryError> {
        let query: DictionaryType = ["deviceNumber": UIDevice.uuidString]
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.GetProfile.self,
                target: .getUserProfileFromDeviceId(parameters: query)
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
    
    /// 쿼리 기반 프로필 생성
    func fetchProfile(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError> {
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.GetProfile.self,
                target: .getUserProfileFromId(path: query.path)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
//                    promise(.failure(failure))
                    break
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 프로필 생성
    func createProfile(query: CreateUserQuery) -> AnyPublisher<Profile, RepositoryError> {
        return Future { promise in
            let requestDTO = RequestDTO.CreateUserProfileDTO(query: query)
            self.apiClient.request(
                ResponseDTO.CreateProfile.self,
                target: .createUserProfile(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
//                    promise(.failure(failure))
                    break
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 프로필 삭제
    func deleteProfile(query: DeleteProfileQuery) -> AnyPublisher<String, RepositoryError> {
        let requestDTO = RequestDTO.DeleteProfile(query: query)
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.DeleteProfile.self,
                target: .deleteUserProfile(path: requestDTO.path)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(_):
//                    promise(.failure(failure))
                    break
                }
            }
        }.eraseToAnyPublisher()
    }
}
