//
//  APIClient.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import Foundation
import Combine

final class APIClient {

    func send() -> AnyPublisher<CreateMember, Error> {
        let url = URL(string: "")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: CreateMember.self, decoder: JSONDecoder())
            .catch { _ in Empty<CreateMember, Error>() }
//            .tryMap { output in
//                guard let response = output.response as? HTTPURLResponse,
//                      (200..<300) ~= response.statusCode 
//                else { throw URLError(.badServerResponse) }
//                
//                return output.data
//            }
//            .decode(type: CreateMember.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct CreateMember: Decodable {
    var userCode: String = ""
}
