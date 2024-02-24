//
//  SubwayStationRepositoryType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Combine

protocol SubwayStationRepository {
    func searchSubwayStations(query: SearchSubwayStationQuery) -> AnyPublisher<[SubwayInfo], RepositoryError>
}
