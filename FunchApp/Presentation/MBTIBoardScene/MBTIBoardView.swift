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
                    
                    Text("수집 도감")
                        .font(.Funch.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text("\(viewModel.profile.userNickname)님이 매칭한 친구들이에요!")
                        .font(.Funch.body)
                        .foregroundColor(.gray300)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    Text("MBTI")
                        .font(.Funch.subtitle2)
                        .foregroundColor(.gray400)
                    
                    Spacer()
                        .frame(height: 12)
                    
                    LazyVGrid(columns: [.init(.adaptive(minimum: 74))]) {
                        ForEach(viewModel.mbtiTiles, id: \.0) { (mbti, opacity) in
                            boardCell(mbti, opacity: opacity)
                                .frame(width: (geometry.size.width - 40 - 24) / 4,
                                       height: (geometry.size.width - 40 - 24) / 4)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
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
        let imageResource = MBTI(rawValue: mbti.lowercased())?.imageResource ?? []
        return VStack {
            if opacity == 0 {
                Image(imageResource[0])
            } else {
                Image(imageResource[1])
                    .opacity(opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray800)
    }
}
