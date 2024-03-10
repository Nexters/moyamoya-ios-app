//
//  HomePresentation.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/22/24.
//

import SwiftUI

enum HomePresentation: Hashable, Identifiable {
    var id: Int { hashValue }
    
    case profile
    case matchResult(MatchingInfo)
    case mbtiCollection
    case easterEgg
    case multiProfile
}

struct HomePresentationView: View {
    @EnvironmentObject var container: DIContainer
    @State var presentation: HomePresentation
    var viewModel: HomeViewModel
    
    var body: some View {
        switch presentation {
        case .profile:
            NavigationStack {
                ProfileViewBuilder(
                    container,
                    delegate: viewModel
                ).body
            }
//            .onDisappear {
//                viewModel.send(action: .load)
//            }
        case let .matchResult(matchingInfo):
            NavigationStack {
                MatchResultViewBuilder(
                    container,
                    matchingInfo: matchingInfo
                ).body
            }
        case .mbtiCollection:
            NavigationStack {
                MBTIBoardViewBuilder(container).body
            }
        case .easterEgg:
            NavigationStack {
                EasterEggViewBuilder(container).body
            }
        case .multiProfile:
            NavigationStack {
                MultiProfileListViewBuilder(
                    container,
                    delegate: viewModel
                ).body
            }
//            .onDisappear {
//                viewModel.send(action: .load)
//            }
        }
    }
}
