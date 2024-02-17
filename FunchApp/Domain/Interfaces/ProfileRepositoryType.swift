//
//  Repositories.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import Moya

protocol ProfileRepositoryType {
    func fetchProfile(completion: @escaping (Result<Profile, MoyaError>) -> Void)
    func fetchProfileId(
        userQuery: FetchUserQuery,
        completion: @escaping (Result<Profile, MoyaError>) -> Void
    )
    func createProfile(
        createUserQuery: CreateUserQuery,
        completion: @escaping (Result<Profile, MoyaError>) -> Void
    )
}
