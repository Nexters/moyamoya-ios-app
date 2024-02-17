//
//  HomeSceneUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation

protocol HomeUseCaseType {
    func fetchProfile(completion: @escaping (Profile) -> Void)
    func searchUser(requestId: String,
                    targetUserCode: String,
                    completion: @escaping (Profile) -> Void)
}

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
            case let .success(profile):
                completion(profile)
            case .failure(_):
                // !!!: - 에러 핸들링 해야하는데, 아직 기획이 정해진게 없어서 비워둠.
                break
            }
        }
    }
    
    /// `상대 프로필` 검색
    func searchUser(requestId: String,
                    targetUserCode: String,
                    completion: @escaping (Profile) -> Void) {
        let searchUserQuery = MatchingUserQuery(requestId: requestId, targetUserCode: targetUserCode)
        matchingRepository.matchingUser(searchUserQuery: searchUserQuery) { result in
            switch result {
            case .success(let success):
                break
            case .failure(_):
                // !!!: - 에러 핸들링 해야하는데, 아직 기획이 정해진게 없어서 비워둠.
                break
            }
        }
    }
}
