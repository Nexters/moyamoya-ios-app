//
//  SubwayStationRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation
import Moya

final class SubwayStationRepository: SubwayStationRepositoryType {
    private let provider: MoyaProvider<DefaultTargetType>
    
    init() {
        provider = MoyaProvider<DefaultTargetType>()
    }
    
    /// `지하철역` 검색
    func searchSubwayStations(
        searchSubwayStationQuery: SearchSubwayStationQuery,
        completion: @escaping (Result<Profile, Error>) -> Void
    ) {
        let requestDTO = RequestDTO.SearchSubwayStation(query: searchSubwayStationQuery)
        provider.request(.searchSubwayStations(parameters: requestDTO.toDitionary)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(ResponseDTO.GetProfileDTO.self, from: response.data)
                completion(.success(data!.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
