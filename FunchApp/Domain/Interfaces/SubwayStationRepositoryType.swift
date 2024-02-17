//
//  SubwayStationRepositoryType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation
import Moya

protocol SubwayStationRepositoryType {
    func searchSubwayStations(
        searchSubwayStationQuery: SearchSubwayStationQuery,
        completion: @escaping (Result<[SubwayInfo], MoyaError>) -> Void
    )
}
