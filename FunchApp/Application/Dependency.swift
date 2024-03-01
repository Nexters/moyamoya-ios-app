//
//  Dependency.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

final class DIContainer: ObservableObject {
    let profileRepository = ProfileRepositoryImpl()
    let mbtiRepository = MBTIRepositoryImpl()
    let matchingRepository = MatchingRepositoryImpl()
    let subwayStationRepository = SubwayStationRepositoryImpl()
}
