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
    
    init(repository: SubwayStationRepository) {
        self.repository = repository
    }
    
    func execute(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], RepositoryError> {
        repository.searchSubwayStations(query: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
