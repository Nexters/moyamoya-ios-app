//
//  HomeViewScene.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                codeSearchView
                    .padding(.top, 8)
                
                Spacer()
                    .frame(height: 8)
                
                HStack(spacing: 0) {
                    myCodeView
                    Spacer()
                        .frame(width: 8)
                    Button {
                        viewModel.send(action: .presentation(.profile))
                    } label: {
                        myProfileView
                    }
                }
                
                Spacer()
                    .frame(height: 8)
                
                lookupCountView
                
                Spacer()
                    .frame(height: 8)
                
                HStack(spacing: 0) {
                    Button {
                        viewModel.send(action: .releaseNote)
                    } label: {
                        releaseNoteView
                    }
                    .padding(.trailing, 8)
                    
                    Button {
                        viewModel.send(action: .releaseNote)
                    } label: {
                        bingoMBTIBoardView
                    }
                    .padding(.trailing, 8)
                    
                    Button {
                        viewModel.send(action: .releaseNote)
                    } label: {
                        releaseNoteView
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            viewModel.send(action: .load)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .fullScreenCover(item: $viewModel.presentation) { presentation in
            switch presentation {
            case .profile:
                NavigationStack { 
                    ProfileViewBuilder(container: container).body
                }
            case let .matchResult(matchingInfo):
                NavigationStack {
                    MatchResultViewBuilder(container: container, matchingInfo: matchingInfo).body
                }
            }
        }
        .toolbar {
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
    
    /// 코드 검색영역
    private var codeSearchView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("우리는 잘 맞을까?")
                .font(.Funch.title2)
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 2)
            
            Text("궁합부터 공통점까지 다양한 정보가 기다려요!")
                .font(.Funch.body)
                .foregroundColor(.gray300)
            
            Spacer()
                .frame(height: 16)
            
            FunchTextField(
                text: $viewModel.searchCodeText,
                placeholderText: "친구 코드를 입력하고 매칭하기",
                backgroundColor: .gray700,
                trailingButtonImage: Image(.iconSearchYellow), 
                onTapButton: {
                    viewModel.send(action: .matching)
                }
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
            Image(.code)
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("나의 코드")
                    .font(.Funch.body)
                    .foregroundColor(.gray400)
                
                Text(viewModel.profile?.userCode ?? "----")
                    .font(.Funch.subtitle2)
                    .overlay {
                        Gradient.funchGradient(type: .lemon500)
                            .mask {
                                Text(viewModel.profile?.userCode ?? "----")
                                    .font(.Funch.subtitle2)
                            }
                    }
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
            Image(.profile)
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(height: 8)
            
            Text("내 프로필")
                .font(.Funch.body)
                .foregroundColor(.gray400)
        }
        .frame(width: 101, height: 92)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    /// 프로필 조회수 영역
    private var lookupCountView: some View {
        HStack(spacing: 0) {
            Image(.look)
                .resizable()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("내 프로필을")
                    .font(.Funch.body)
                    .foregroundColor(.gray400)
                
                Text("\(viewModel.profile?.viewerShip ?? "00")명이 조회했어요.")
                    .font(.Funch.subtitle2)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 92)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        .frame(maxWidth: .infinity)
    }
    
    private var releaseNoteView: some View {
        VStack(spacing: 0) {
            Text("🚀")
                .font(.system(size: 40))
            
            Spacer()
                .frame(height: 8)
            
            Text("릴리즈노트")
                .font(.Funch.body)
                .foregroundColor(.gray400)
        }
        .frame(width: 101, height: 92)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    private var bingoMBTIBoardView: some View {
        VStack(spacing: 0) {
            Text("🎹")
                .font(.system(size: 40))
            
            Spacer()
                .frame(height: 8)
            
            Text("MBTI 컬렉션")
                .font(.Funch.body)
                .foregroundColor(.gray400)
        }
        .frame(height: 92)
        .frame(maxWidth: .infinity)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}
