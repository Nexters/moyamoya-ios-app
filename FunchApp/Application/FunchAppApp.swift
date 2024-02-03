//
//  FunchAppApp.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

@main
struct FunchAppApp: App {
    let useCsae = ProfileUseCase()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ProfileView()
                    .onAppear {
                        useCsae.createProfile(
                            createUserQuery: .init(name: "박당근",
                                                   birth: "2002-02-01",
                                                   major: "backend",
                                                   clubs: ["nexters"],
                                                   subwayStationName: ["동대문"],
                                                   mbti: "ISTP")
                        ) { result in
                            
                            switch result {
                            case .success(let success):
                                print("result \(result)")
                            case .failure(let failure):
//                                print("result \(result)")
                                break
                            }
                        }
                    }
            }
            
            
        }
    }
}
