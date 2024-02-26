//
//  mbtiBoardView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/22/24.
//

import SwiftUI

struct MBTIBoardView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MBTIBoardViewModel
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 8)
                    
                    Text("달성기록")
                        .font(.Funch.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text("\(viewModel.profile.userNickname)님이 매칭한 친구들이에요")
                        .font(.Funch.body)
                        .foregroundColor(.gray300)
                    
                    Spacer()
                        .frame(height: 24)
                    
                    LazyVGrid(columns: [.init(.adaptive(minimum: 74))]) {
                        ForEach(viewModel.mbtiTiles, id: \.0) { (mbti, opacity) in
                            boardCell(mbti, opacity: opacity)
                                .frame(width: (geometry.size.width - 40 - 24) / 4,
                                       height: (geometry.size.width - 40 - 24) / 4)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(.iconX)
                        .foregroundColor(.black)
                }
            }
        }
        .toolbarBackground(Color.gray900, for: .navigationBar)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            viewModel.send(action: .load)
        }
    }
    
    func boardCell(_ mbti: String, opacity: CGFloat) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    opacity == 0
                    ? Color.gray800
                    : Color.lemon500.opacity(opacity)
                )
            
            Text(mbti)
                .font(.Funch.title1)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .padding()
        }
    }
}
