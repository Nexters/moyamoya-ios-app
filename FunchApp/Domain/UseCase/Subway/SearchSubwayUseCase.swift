//
//  SearchSubwayUseCase.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/24/24.
//

import Combine

protocol SearchSubwayUseCase {
    func execute(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], Error>
}

final class DefaultSearchSubwayUseCase {
    private let repository: SubwayStationRepository
    
    init() {
        self.repository = SubwayStationRepository()
    }
    
    func execute(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], Error> {
        return Future { [weak self] promise in
            guard let self else { return }
            self.repository.searchSubwayStations(searchSubwayStationQuery: query) { result in
                switch result {
                case .success(let subwayInfos):
                    promise(.success(subwayInfos))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
