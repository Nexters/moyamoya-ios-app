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
        // !!!: - Services로 분리
        let profileRepository: ProfileRepository
        let mbtiRepository: MBTIRepository
        let matchingRepository: MatchingRepository
        let subwayStationRepository: SubwayStationRepository
    }
    
    struct Delegate {
        
//        var ProfileViewDelegate: ProfileViewDelegate = ProfileDelegate
    }
    
    private(set) var dependency: Dependency
    
    private(set) var openUrl: OpenURLProtocol
    var userStorage: UserStorageProtocol
    
    init() {
        let apiClient = APIClient()
        
        self.dependency = Dependency(
            profileRepository: ProfileRepositoryImpl(apiClient: apiClient),
            mbtiRepository: MBTIRepositoryImpl(),
            matchingRepository: MatchingRepositoryImpl(apiClient: apiClient),
            subwayStationRepository: SubwayStationRepositoryImpl(apiClient: apiClient)
        )
        
        // !!!: - 데이터 Combine으로 형태로 변환
        self.userStorage = UserDefaultManager()
        self.openUrl = OpenURLManager()
    }
}
