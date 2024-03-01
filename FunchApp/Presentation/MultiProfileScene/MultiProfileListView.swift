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
    @Published var selection: Profile?
    
    private var ineject: DIContainer.Inject
    
    init(inject: DIContainer.Inject) {
        self.ineject = inject
        self.profiles = ineject.userStorage.profiles.sorted { $0.createAt > $1.createAt }
        
        self.selection = ineject.userStorage.selectionProfile == nil
        ? self.profiles.first
        : self.ineject.userStorage.selectionProfile
    }
    
    func send(action: Action) {
        switch action {
        case let .selection(profile):
            ineject.userStorage.selectionProfile = profile
            self.selection = profile
        }
    }
}

struct MultiProfileListView: View {
    
    @StateObject var viewModel: MultiProfileListViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: MultiProfileListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea()
            
            List(viewModel.profiles, id: \.userCode) { profile in
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
                    viewModel.send(action: .selection(profile))
                }
                .listRowBackground(
                    viewModel.selection == profile
                    ? Color.lemon500
                    : Color.gray800
                )
            }
            .scrollContentBackground(.hidden)
        }
        .toolbarBackground(Color.gray900, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(.iconX)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
//                    viewModel.send(action: .feedback)
                } label: {
                    Text("피드백 보내기")
                        .foregroundColor(.white)
                        .customFont(.body)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.gray800)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
            }
        }
    }
}
