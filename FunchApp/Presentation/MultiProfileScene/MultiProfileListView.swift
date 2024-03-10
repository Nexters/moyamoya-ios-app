//
//  MultiProfileListView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import SwiftUI

struct MultiProfileListView: View {
    @StateObject var viewModel: MultiProfileListViewModel
    
    @Environment(\.dismiss) var dismiss
    
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
                            .padding(.bottom, 8)
                        
                        Text("닉네임 " + profile.userNickname)
                            .font(.Funch.body)
                            .foregroundColor(.gray400)
                            .padding(.bottom, 4)
                        
                        Text("조회수 " + profile.viewerShip)
                            .font(.Funch.body)
                            .foregroundColor(.gray400)
                    }
                    
                    Spacer()
                    
                    if viewModel.selection == profile {
                        Image(systemName: "checkmark.circle")
                    }
                }
                .contentShape(Rectangle())
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
        .onAppear {
            viewModel.send(action: .load)
        }
        .fullScreenCover(item: $viewModel.presentation) { presentation in
            MultiProfileListPresentationView(presentation: presentation)
        }
        .onReceive(viewModel.$dismiss) { isDismiss in
            if isDismiss { dismiss() }
        }
        .toolbarBackground(Color.gray900, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.send(action: .dismiss)
                } label: {
                    Image(.iconX)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.send(action: .presentation(.create))
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(.lemon500)
                }
            }
        }
    }
}

