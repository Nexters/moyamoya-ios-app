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
                        .clipShape(RoundedRectangle(cornerRadius: 16.0))
                }
                
            }
        }
    }
    
    /// 코드 검색영역
    private var codeSearchView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("우리는 잘 맞을까?")
                .font(.system(size: 20, weight: .bold))
            
            Spacer()
                .frame(height: 2)
            
            Text("궁합부터 공통점까지 다양한 정보가 기다려요!")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
            
            Spacer()
                .frame(height: 16)
            
            TextField("여기 성민이 텍스트 필드로 교체할 것", text: $viewModel.state.serachCodeText)
                .background(.blue)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal, 20)
    }
    
    /// 내 코드가 나타나는 영역
    private var myCodeView: some View {
        HStack(spacing: 0) {
            Image(systemName: "plus")
                .frame(width: 40, height: 40)
                .background(.blue)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("나의 코드")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
                
                Text("U23S")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.leading, 20)
        .frame(maxWidth: .infinity)
        
    }
    
    /// 내 프로필 영역
    private var myProfileView: some View {
        VStack(spacing: 0) {
            Image(systemName: "plus")
                .frame(width: 40, height: 40)
                .background(.blue)
            
            Spacer()
                .frame(height: 8)
            
            Text("내 프로필")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 11.5)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.trailing, 20)
    }
    
    /// 프로필 조회수 영역
    private var lookupCountView: some View {
        HStack(spacing: 0) {
            Image(systemName: "plus")
                .frame(width: 40, height: 40)
                .background(.blue)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("내 프로필을")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
                
                Text("00명이 조회했어요.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}
