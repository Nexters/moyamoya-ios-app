//
//  Repositories.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Moya
import Combine

protocol ProfileRepositoryType {
    func fetchProfile() -> AnyPublisher<Profile, RepositoryError>
    func fetchProfile(query: FetchUserQuery) -> AnyPublisher<Profile, RepositoryError>
    func createProfile(query: CreateUserQuery) -> AnyPublisher<Profile, RepositoryError>
    func deleteProfile(query: DeleteProfileQuery) -> AnyPublisher<String, RepositoryError>
}
