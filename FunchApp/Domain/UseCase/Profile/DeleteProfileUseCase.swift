//
//  DeleteProfileUseCase.swift
//  FunchApp
//
//  Created by 이성민 on 2/21/24.
//

import Foundation
import Combine

protocol DeleteProfileUseCase {
    func execute(requestId: String) -> AnyPublisher<String, RepositoryError>
}

final class DefaultDeleteProfileUseCase: DeleteProfileUseCase {
    
    private let profileRepository: ProfileRepositoryType
    
    init() {
        self.profileRepository = ProfileRepository()
    }
    
    func execute(requestId: String) -> AnyPublisher<String, RepositoryError> {
        let query = DeleteProfileQuery(profileId: requestId)
        return profileRepository.deleteProfile(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
