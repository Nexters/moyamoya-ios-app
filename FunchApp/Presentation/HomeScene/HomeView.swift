//
//  HomeViewScene.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var state = State()
    
    /// 상태
    struct State {
        /// 코드 검색 텍스트 필드
        var serachCodeText: String = ""
    }
}

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().backgroundColor = .orange
    }
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                codeSearchView
                
                Spacer()
                    .frame(height: 8)
                
                HStack(spacing: 0) {
                    myCodeView
                    Spacer()
                        .frame(width: 8)
                    myProfileView
                }
                
                Spacer()
                    .frame(height: 8)
                
                lookupCountView
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // action
                } label: {
                    Text("피드백 보내기")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
                
            }
        }
    }
    
    /// 코드 검색영역
    private var codeSearchView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("우리는 잘 맞을까?")
                .font(.Funch.title2)
                .foregroundStyle(.white)
            
            Spacer()
                .frame(height: 2)
            
            Text("궁합부터 공통점까지 다양한 정보가 기다려요!")
                .font(.Funch.body)
                .foregroundStyle(.gray300)
            
            Spacer()
                .frame(height: 16)
            
            FunchTextField(
                text: $viewModel.state.serachCodeText,
                placeholderText: "친구 코드를 입력하고 매칭하기",
                backgroundColor: .gray700,
                buttonAction: {
                    // FIXME: api 통신
                },
                trailingButtonImage: Image(.iconSearchYellow)
            )
        }
        .padding(.horizontal, 16)
        .frame(height: 178)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Gradient.funchGradient(type: .lemon500), lineWidth: 1.0)
        }
    }
    
    /// 내 코드가 나타나는 영역
    private var myCodeView: some View {
        HStack(spacing: 0) {
            Image(systemName: "plus")
                .frame(width: 40, height: 40)
                .foregroundStyle(.gray400)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("나의 코드")
                    .font(.Funch.body)
                    .foregroundStyle(.gray400)
                
                Text("U23S")
                    .font(.Funch.subtitle2)
                    .foregroundStyle(Gradient.funchGradient(type: .lemon500))
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 92)
        .frame(maxWidth: .infinity)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    /// 내 프로필 영역
    private var myProfileView: some View {
        VStack(spacing: 0) {
            Image(systemName: "plus")
                .foregroundStyle(.gray400)
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(height: 8)
            
            Text("내 프로필")
                .font(.Funch.body)
                .foregroundStyle(.gray400)
        }
        .frame(width: 101, height: 92)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    /// 프로필 조회수 영역
    private var lookupCountView: some View {
        HStack(spacing: 0) {
            Image(systemName: "plus")
                .frame(width: 40, height: 40)
                .foregroundStyle(.gray400)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("내 프로필을")
                    .font(.Funch.body)
                    .foregroundStyle(.gray400)
                
                Text("00명이 조회했어요.")
                    .font(.Funch.subtitle2)
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 92)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}
