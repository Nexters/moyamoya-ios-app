//
//  APIClient.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/31/24.
//

import Foundation
import Moya

final class APIClient {
    private let provider: MoyaProvider<DefaultTargetType>

    init() {
        provider = MoyaProvider<DefaultTargetType>()
    }
    
    func send<T: Decodable>(
        T: T.Type,
        target: DefaultTargetType,
        completion: @escaping (Result<T, MoyaError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                response.statusCode ~= 200
                do {
                    let data = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(data))
                } catch {
                    completion(.failure(.objectMapping(error, response)))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
