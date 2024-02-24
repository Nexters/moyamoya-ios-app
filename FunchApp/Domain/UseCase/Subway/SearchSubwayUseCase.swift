//
//  SearchSubwayUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/24/24.
//

import Foundation
import Combine

protocol SearchSubwayUseCase {
    func execute(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], Error>
}

final class DefaultSearchSubwayUseCase {
    private let repository: SubwayStationRepository
    
    init() {
        self.repository = SubwayStationRepositoryImpl()
    }
    
    func execute(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], RepositoryError> {
        repository.searchSubwayStations(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
