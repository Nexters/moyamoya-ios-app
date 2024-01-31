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
    
    /// api 요청에 사용
    func request<T: Respondable>(
        _ T: T.Type,
        target: DefaultTargetType,
        completion: @escaping (Result<T, MoyaError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                guard (200..<300) ~= response.statusCode else {
                    completion(.failure(.statusCode(response)))
                    return
                }
                
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
