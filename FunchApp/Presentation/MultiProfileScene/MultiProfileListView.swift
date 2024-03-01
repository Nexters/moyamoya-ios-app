//
//  MultiProfileListView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

final class MultiProfileListViewModel: ObservableObject {
 
    enum Action {
        case load
    }
    
    @Published var profiles: [Profile] = [.empty, .testableValue]
    
    private var ineject: DIContainer.Inject
    
    init(
        inject: DIContainer.Inject
    ) {
        self.ineject = inject
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            self.profiles = ineject.userStorage.profiles
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
            
            List(ineee, id: \.self) { profile in
                HStack {
                    VStack(alignment: .leading,
                           spacing: 0) {
                        
                        Text(profile)
                            .font(.Funch.title1)
                            .foregroundStyle(.white)
                            .padding(.bottom, 10)
                            
                        Text("닉네임")
                    }
                    
                    Spacer()
                    
                    if selection == profile {
                        Image(systemName: "checkmark.circle")
                    }
                }
                .onTapGesture {
                    selection = profile
                }
                .listRowBackground(
                    selection == profile
                    ? Color.lemon500
                    : Color.gray800
                )
            }
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            viewModel.send(action: .load)
        }
    }
}
//
#Preview {
    @StateObject var diContainer = DIContainer()
    return MultiProfileListView(viewModel: MultiProfileListViewModel(inject: diContainer.inject))
}
