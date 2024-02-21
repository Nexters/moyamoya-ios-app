//
//  DeleteProfileUseCaseType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/21/24.
//

import Foundation


protocol DeleteProfileUseCaseType {}

final class DeleteProfileUseCase: DeleteProfileUseCaseType {
    private let profileRepository: ProfileRepository
    
    init() {
        self.profileRepository = ProfileRepository()
    }
}
