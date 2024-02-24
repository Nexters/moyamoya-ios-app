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
    
    private let useCase = MBTIBoardUseCase()
    private let mbties = MBTI.allCases
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.gray900
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Text("달성기록")
                        .font(.Funch.title2)
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .padding(.bottom, 2)
                    
                    Text("\(useCase.profile().userNickname)님이 매칭한 친구들이에요")
                        .font(.Funch.body)
                        .foregroundColor(.gray300)
                        .padding(.bottom, 24)
                        
                    LazyVGrid(columns: [.init(.adaptive(minimum: 74))]) {
                        ForEach(mbties, id: \.rawValue) { mbti in
                            boardCell(mbti.rawValue)
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
    
    func boardCell(_ mbti: String) -> some View {
        let opacity = Double(count(mbti)) * 0.2
        return ZStack {
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
    
    func save(mbti: String) {
        useCase.save(mbti: mbti)
    }
    
    func count(_ mbti: String) -> Int {
        useCase.count(mbti: mbti)
    }
}

#Preview {
    NavigationStack {
        MBTIBoardView(viewModel: .init(useCase: .init()))
    }
}

