//
//  HomeSceneUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import Combine

protocol HomeUseCaseType {
    func fetchProfile(completion: @escaping (Profile) -> Void)
    func matchingProfile(requestId: String,
                    targetUserCode: String,
                    completion: @escaping (Result<MatchingInfo, Error>) -> Void)
}

final class HomeUseCase {
    
    private let profileRepository: ProfileRepositoryType
    private let matchingRepository: MatchingRepositoryType
    private let bingoMBTIRepository: BingoMBTIRepository
    
    init() {
        self.profileRepository = ProfileRepository()
        self.matchingRepository = MatchingRepository()
        self.bingoMBTIRepository = BingoMBTIRepository()
    }
    
    /// `본인 프로필` 정보
    func fetchProfile() -> AnyPublisher<Profile, RepositoryError> {
        profileRepository.fetchProfile()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// `상대 프로필` 매칭
    func matchingProfile(requestId: String,
                    targetUserCode: String,
                    completion: @escaping (Result<MatchingInfo, Error>) -> Void) {
        let searchUserQuery = MatchingUserQuery(requestId: requestId, targetUserCode: targetUserCode)
        matchingRepository.matchingUser(searchUserQuery: searchUserQuery) { result in
            switch result {
            case .success(let success):
                self.bingoMBTIRepository.save(mbti: success.profile.mbti)
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
