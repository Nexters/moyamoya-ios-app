//
//  FetchProfileUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/3/24.
//

import Foundation

final class FetchProfileUseCase {
    private let profileRepository: ProfileRepository
    
    init() {
        self.profileRepository = ProfileRepository()
    }
    
    /// 본인 프로필 생성
    func fetchProfileFromDeviceId(completion: @escaping (Result<Void, Error>) -> Void) {
        profileRepository.fetchProfile { result in
            switch result {
            case .success(let success):
                completion(.success(()))
            case .failure(let failure):
                break
            }
        }
    }
}
