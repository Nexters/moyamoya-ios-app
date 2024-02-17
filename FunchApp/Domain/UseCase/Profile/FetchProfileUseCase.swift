//
//  FetchProfileUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/3/24.
//

import Foundation

protocol FetchProfileUseCaseType {
    func fetchProfileFromDeviceId(completion: @escaping (Result<Profile, Error>) -> Void)
    func fetchProfileFromId(
        query: FetchUserQuery,
        completion: @escaping (Result<Profile, Error>) -> Void
    )
}

final class FetchProfileUseCase: FetchProfileUseCaseType {
    private let profileRepository: ProfileRepository
    
    init() {
        self.profileRepository = ProfileRepository()
    }
    
    /// 디바이스 기반으로 id 조회
    func fetchProfileFromDeviceId(completion: @escaping (Result<Profile, Error>) -> Void) {
        profileRepository.fetchProfile { result in
            switch result {
            case .success(let profile):
                Task { @MainActor in
                    completion(.success(profile))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    /// 프로필 아이디 기반으로 조회
    func fetchProfileFromId(
        query: FetchUserQuery,
        completion: @escaping (Result<Profile, Error>) -> Void
    ) {
        profileRepository.fetchProfileId(userQuery: query) { result in
            switch result {
            case .success(let profile):
                Task { @MainActor in
                    completion(.success(profile))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
