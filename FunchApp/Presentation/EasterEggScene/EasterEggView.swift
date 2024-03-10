//
//  EasterEggView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/26/24.
//

import SwiftUI

struct EasterEggView: View {
    @StateObject var viewModel: EasterEggViewModel

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea()
            
            GeometryReader { geomety in
                VStack(alignment: .leading,
                       spacing: 0) {
                    
                    Text("이스터에그")
                        .font(.Funch.title2)
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .padding(.leading, 20)
                        .padding(.bottom, 2)
                    
                    Text("스스로를 매칭할 생각을 한 당신")
                        .font(.Funch.body)
                        .foregroundColor(.gray300)
                        .padding(.leading, 20)
                        .padding(.bottom, 24)
                    
                    Image(.easterEgg)
                        .resizable()
                        .frame(width: geomety.size.width, height: geomety.size.width)
                        .padding(.bottom, 24)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text("이스터에그를 발견하셨나요?")
                            Text("피드백 보내기 버튼을 통해")
                            Text("1. 이스터에그를 발견했다는 사실과")
                            Text("2. 연락 가능한 이메일을 알려주세요.")
                            Text("우리팀이 제공하는")
                            Text("작은 선물을 보내드립니다.🍀")
                        }
                        Spacer()
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                }
            }
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
                    viewModel.send(action: .feedback)
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
