//
//  DeleteProfileUseCase.swift
//  FunchApp
//
//  Created by 이성민 on 2/21/24.
//

import Foundation

protocol DeleteProfileUseCaseType {
    func deleteProfile(completion: @escaping (Result<Void, Error>) -> Void)
}

final class DeleteProfileUseCase: DeleteProfileUseCaseType {
    private let profileRepository: ProfileRepositoryType
    
    init() {
        self.profileRepository = ProfileRepository()
    }
    
    func deleteProfile(completion: @escaping (Result<Void, Error>) -> Void) {
        profileRepository.deleteProfile { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
