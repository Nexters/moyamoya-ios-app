//
//  File.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation

final class CreateProfileUseCase {
    private let profileRepository: ProfileRepository
    
    init() {
        self.profileRepository = ProfileRepository()
    }
    
    /// 본인 프로필 생성
    func createProfile(createUserQuery: CreateUserQuery, completion: @escaping (Result<Profile, Error>) -> Void) {
        profileRepository.createProfile(createUserQuery: createUserQuery) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let failure):
                break
            }
        }
    }
}
