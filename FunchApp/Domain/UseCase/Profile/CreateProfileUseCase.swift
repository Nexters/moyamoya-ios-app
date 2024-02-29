//
//  File.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import Combine

protocol CreateProfileUseCase {
    func createProfile(query: CreateUserQuery)-> AnyPublisher<Profile, RepositoryError>
}

final class DefaultCreateProfileUseCase: CreateProfileUseCase {
    private let profileRepository: ProfileRepository
    
    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    /// 본인 프로필 생성
    func createProfile(query: CreateUserQuery)-> AnyPublisher<Profile, RepositoryError> {
        profileRepository.createProfile(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
