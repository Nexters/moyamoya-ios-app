//
//  SubwayStationRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import SwiftUI
import Combine
import Moya

final class SubwayStationRepositoryImpl: SubwayStationRepository {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    /// `지하철역` 검색
    func searchSubwayStations(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], RepositoryError> {
        let requestDTO = RequestDTO.SearchSubwayStation(query: query)
        return Future { [weak self] promise in
            guard let self else { return }
            self.apiClient.request(
                ResponseDTO.SearchSubwayStation.self,
                target: .searchSubwayStations(parameters: requestDTO.toDitionary)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(let failure):
                    //                    promise(.failure(failure))
                    break
                }
            }
        }.eraseToAnyPublisher()
    }
}
