//
//  SubwayStationRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import SwiftUI
import Moya

final class SubwayStationRepository: SubwayStationRepositoryType {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    /// `지하철역` 검색
    func searchSubwayStations(
        searchSubwayStationQuery: SearchSubwayStationQuery,
        completion: @escaping (Result<[SubwayInfo], MoyaError>) -> Void
    ) {
        let requestDTO = RequestDTO.SearchSubwayStation(query: searchSubwayStationQuery)
        apiClient.request(
            ResponseDTO.SearchSubwayStation.self,
            target: .searchSubwayStations(parameters: requestDTO.toDitionary)
        ) { result in
            switch result {
            case .success(let success):
                SwiftUI.Task { @MainActor in
                    completion(.success(success.toDomain()))
                }
            case .failure(let failure):
                SwiftUI.Task { @MainActor in
                    completion(.failure(failure))
                }
            }
        }
    }
}
