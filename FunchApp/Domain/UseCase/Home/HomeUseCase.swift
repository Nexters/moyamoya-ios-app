//
//  HomeSceneUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation

protocol HomeUseCaseType {
    func fetchProfile(completion: @escaping (Profile) -> Void)
    func matchingProfile(requestId: String,
                    targetUserCode: String,
                    completion: @escaping (Result<MatchingInfo, Error>) -> Void)
}

final class HomeUseCase: HomeUseCaseType {
    
    private let profileRepository: ProfileRepositoryType
    private let matchingRepository: MatchingRepositoryType
    private let mbtiRepository: MBTIRepository
    
    init() {
        self.profileRepository = ProfileRepository()
        self.matchingRepository = MatchingRepository()
        self.mbtiRepository = MBTIRepository()
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
    
    /// `상대 프로필` 매칭
    func matchingProfile(requestId: String,
                    targetUserCode: String,
                    completion: @escaping (Result<MatchingInfo, Error>) -> Void) {
        let searchUserQuery = MatchingUserQuery(requestId: requestId, targetUserCode: targetUserCode)
        matchingRepository.matchingUser(searchUserQuery: searchUserQuery) { result in
            switch result {
            case .success(let success):
                self.mbtiRepository.save(mbti: success.profile.mbti)
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
