//
//  HomeSceneUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation

final class HomeUseCase {
    
    private let profileRepository: ProfileRepository
    private let matchingRepository: MatchingRepository
    
    init() {
        self.profileRepository = ProfileRepository()
        self.matchingRepository = MatchingRepository()
    }
    
    /// `본인 프로필` 정보
    func fetchProfile(completion: @escaping (Profile) -> Void) {
        profileRepository.fetchProfile { result in
            switch result {
            case .success(let profile):
                completion(profile)
            case .failure(_):
                // TODO: - error handling
                completion(.testableValue)
            }
        }
    }
    
    /// `상대 프로필` 검색
    func searchUser(userCode: String, completion: @escaping (Profile) -> Void) {
        let searchUserQuery = SearchUserQuery(userCode: userCode)
        matchingRepository.searchUser(searchUserQuery: searchUserQuery) { result in
            switch result {
            case .success(let success):
//                completion()
                break
            case .failure(let failure):
//                completion()
                break
            }
        }
    }
}
