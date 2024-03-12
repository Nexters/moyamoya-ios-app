//
//  MultiProfileListPresentation.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/2/24.
//

import SwiftUI

enum MultiProfileListPresentation: Hashable, Identifiable {
    var id: Int { hashValue }
    
    case create
}

struct MultiProfileListPresentationView: View {
    @EnvironmentObject var container: DIContainer
    @State var presentation: MultiProfileListPresentation
    
    var body: some View {
        switch presentation {
        case .create:
            NavigationStack {
                ProfileEditorViewBuilder(container).body
            }
        }
    }
}
