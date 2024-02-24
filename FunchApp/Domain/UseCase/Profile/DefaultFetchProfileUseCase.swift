//
//  FetchProfileUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/3/24.
//

import Foundation
import Combine

protocol FetchProfileUseCase {
    func fetchProfileFromDeviceId() -> AnyPublisher<Profile, RepositoryError>
    func fetchProfileFromId(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError>
}

final class DefaultFetchProfileUseCase: FetchProfileUseCase {
    private let repository: ProfileRepository
    
    init() {
        self.repository = ProfileRepository()
    }
    
    /// 디바이스 기반으로 id 조회
    func fetchProfileFromDeviceId() -> AnyPublisher<Profile, RepositoryError> {
        repository.fetchProfile()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// 프로필 아이디 기반으로 조회
    func fetchProfileFromId(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError> {
        repository.fetchProfile(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
