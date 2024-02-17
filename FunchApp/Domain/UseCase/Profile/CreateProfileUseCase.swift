//
//  File.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation

protocol CreateProfileUseCaseType {
    func searchSubway(query: SearchSubwayStationQuery, completion: @escaping (Result<[SubwayInfo], Error>) -> Void)
    func createProfile(createUserQuery: CreateUserQuery, completion: @escaping (Result<Profile, Error>) -> Void)
}

final class CreateProfileUseCase: CreateProfileUseCaseType {
    private let subwayRepository: SubwayStationRepository
    private let profileRepository: ProfileRepository
    
    init() {
        self.subwayRepository = SubwayStationRepository()
        self.profileRepository = ProfileRepository()
    }
    
    func searchSubway(query: SearchSubwayStationQuery, completion: @escaping (Result<[SubwayInfo], Error>) -> Void) {
        subwayRepository.searchSubwayStations(searchSubwayStationQuery: query) { result in
            switch result {
            case .success(let subwayInfos):
                DispatchQueue.main.async {
                    completion(.success(subwayInfos))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 본인 프로필 생성
    func createProfile(createUserQuery: CreateUserQuery, completion: @escaping (Result<Profile, Error>) -> Void) {
        profileRepository.createProfile(createUserQuery: createUserQuery) { result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    completion(.success(profile))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
