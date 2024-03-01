//
//  MultiProfileListView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

final class MultiProfileListViewModel: ObservableObject {
 
    enum Action {
        case selection(Profile)
    }
    
    @Published var profiles: [Profile] = [.empty, .testableValue]
    @Published var selection: Profile = .empty
    
    private var ineject: DIContainer.Inject
    
    init(
        inject: DIContainer.Inject
    ) {
        self.ineject = inject
        
        self.profiles = ineject.userStorage.profiles.sorted { $0.createAt > $1.createAt }
//        self.selection = ineject.userStorage.profiles.first
    }
    
    func send(action: Action) {
        switch action {
        case let .selection(profile):
            self.selection = profile
        }
    }
}

struct MultiProfileListView: View {
    
    @StateObject var viewModel: MultiProfileListViewModel
    @State var ineee: [String] = ["1", "2", "3"]
    @State var selection: String = ""
    
    init(viewModel: MultiProfileListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea()
            
            List(viewModel.profiles, id: \.id) { profile in
                HStack {
                    VStack(alignment: .leading,
                           spacing: 0) {
                        
                        Text(profile.userCode)
                            .font(.Funch.title1)
                            .foregroundStyle(.white)
                            .padding(.bottom, 10)
                            
                        Text("닉네임")
                    }
                    
                    Spacer()
                    
                    if viewModel.selection == profile {
                        Image(systemName: "checkmark.circle")
                    }
                }
                .onTapGesture {
                    viewModel.selection = profile
                }
                .listRowBackground(
                    viewModel.selection == profile
                    ? Color.lemon500
                    : Color.gray800
                )
            }
            .scrollContentBackground(.hidden)
        }
    }
}
//
//#Preview {
//    @StateObject var diContainer = DIContainer()
//    return MultiProfileListView(viewModel: MultiProfileListViewModel(inject: diContainer.inject))
//}
