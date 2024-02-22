//
//  BingoBoardView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/22/24.
//

import SwiftUI

class BingoBoardViewModel: ObservableObject {
    
    enum Action {
        case load
    }
    
    private let useCase: BingoBoardUseCase
    
    init(useCase: BingoBoardUseCase) {
        self.useCase = useCase
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            break
        }
    }
}

struct BingoBoardView: View {
    
    private let useCase = BingoBoardUseCase()
    private let mbties = MBTI.allCases
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: [.init(.adaptive(minimum: 80))]) {
                ForEach(mbties, id: \.rawValue) { mbti in
                    boardView(mbti.rawValue)
                        .frame(width: geometry.size.width / 4 - 10,
                               height: geometry.size.width / 4 - 10)
                        .onTapGesture {
                            print(mbti.rawValue)
                            save(mbti: mbti.rawValue)
                        }
                }
            }
            .padding(.horizontal, 10)
        }
    }
    
    func boardView(_ mbti: String) -> some View {
        let count = count(mbti) + 1
        let op = Double(count) * 0.1
        return ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.lemon500.opacity(op))
                
            Text(mbti)
                .font(.system(size: 20))
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
    BingoBoardView()
}

