//
//  Dependency.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

final class DIContainer: ObservableObject {
    @Published var paths: [NavigationDestination] = []
    
    struct Dependency {
        let profileRepository: ProfileRepository
        let mbtiRepository: MBTIRepository
        let matchingRepository: MatchingRepository
        let subwayStationRepository: SubwayStationRepository
    }
    
    private(set) var dependency: Dependency
    
    init() {
        let apiClient = APIClient()
        
        self.dependency = Dependency(
            profileRepository: ProfileRepositoryImpl(apiClient: apiClient),
            mbtiRepository: MBTIRepositoryImpl(),
            matchingRepository: MatchingRepositoryImpl(apiClient: apiClient),
            subwayStationRepository: SubwayStationRepositoryImpl(apiClient: apiClient)
        )
    }
    
    var inject = Inject()
    
    struct Inject {
        var openUrl: OpenURLInterface = OpenURLManager()
        var userStorage: UserStorage = UserDefaultImpl()
    }
}
