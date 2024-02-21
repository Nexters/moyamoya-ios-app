//
//  DeleteProfileUseCase.swift
//  FunchApp
//
//  Created by 이성민 on 2/21/24.
//

import Foundation

protocol DeleteProfileUseCaseType {
    func deleteProfile(
        requestId: String,
        completion: @escaping (Result<String, Error>) -> Void
    )
}

final class DeleteProfileUseCase: DeleteProfileUseCaseType {
    private let profileRepository: ProfileRepositoryType
    
    init() {
        self.profileRepository = ProfileRepository()
    }
    
    func deleteProfile(
        requestId: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let query = DeleteProfileQuery(profileId: requestId)
        profileRepository.deleteProfile(userQuery: query) { result in
            switch result {
            case .success(let deletedId):
                Task { @MainActor in
                    completion(.success(deletedId))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
