//
//  Dependency.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

final class DIContainer: ObservableObject {
    let profileRepository: ProfileRepository
    let mbtiRepository: MBTIRepository
    let matchingRepository: MatchingRepository
    let subwayStationRepository: SubwayStationRepository
    
    init() {
        let apiClient = APIClient()
        
        self.profileRepository = ProfileRepositoryImpl(apiClient: apiClient)
        self.mbtiRepository = MBTIRepositoryImpl()
        self.matchingRepository = MatchingRepositoryImpl(apiClient: apiClient)
        self.subwayStationRepository = SubwayStationRepositoryImpl(apiClient: apiClient)
    }
    
    var inject = Inject()
    
    struct Inject {
        var openUrl: OpenURLInject = OpenURLImplement()
        var userStorage: UserStorage = UserDefaultImpl()
    }
}
