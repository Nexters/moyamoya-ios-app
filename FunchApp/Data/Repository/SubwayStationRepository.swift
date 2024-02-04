//
//  SubwayStationRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation
import Moya

final class SubwayStationRepository: SubwayStationRepositoryType {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    /// `지하철역` 검색
    func searchSubwayStations(
        searchSubwayStationQuery: SearchSubwayStationQuery,
        completion: @escaping (Result<Profile, MoyaError>) -> Void
    ) {
        let requestDTO = RequestDTO.SearchSubwayStation(query: searchSubwayStationQuery)
        apiClient.request(
            ResponseDTO.GetProfile.self,
            target: .searchSubwayStations(parameters: requestDTO.toDitionary)
        ) { result in
            switch result {
            case .success(let success):
                completion(.success(success.toDomain()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
