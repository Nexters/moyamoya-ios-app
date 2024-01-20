//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileEditorView: View {
    
    @State var userNickName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("프로필 만들기")
            Text("프로필을 바탕으로 매칭을 도와드려요")
            
            
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center) {
                    Text("닉네임")
                        .frame(width: 52, alignment: .leading)
                    
                    FunchTextField(onSubmit: {},
                                   bindingText: $userNickName,
                                   placeholder: "test",
                                   rightImage: Image(systemName: "magnifyingglass"))
                }
                
                HStack(alignment: .top) {
                    Text("직군")
                        .frame(width: 52, alignment: .leading)
                    grid
                }
                
                HStack(alignment: .top) {
                    Text("동아리")
                }
                
                HStack(alignment: .top) {
                    Text("MBTI")
                }
                
                HStack(alignment: .top) {
                    Text("생일")
                }
                
                HStack(alignment: .center) {
                    Text("지하철")
                        .frame(width: 52, alignment: .leading)
                    
                    FunchTextField(onSubmit: { print("🤔") },
                                   bindingText: $userNickName,
                                   placeholder: "지하철",
                                   leftImage: Image(systemName: "magnifyingglass"))
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(20)
        .background(Color.gray)
    }
    
    
    let testDummy: [String] = [
        "test",
        "asdfasdf",
        "fe",
        "awvewc"
    ]
    let columns: [GridItem] = [
//        .init(.fixed(50)),
//        .init(.fixed(100)),
//        .init(.fixed(120))
//        .init(.flexible(maximum: 300)),
//        .init(.flexible(maximum: 300)),
//        .init(.flexible(maximum: 300)),
        .init(.adaptive(minimum: 50), spacing: 10)
    ]
    var grid: some View {
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach((2...9), id: \.self) { t in
                Text("\(t * t * t * t * t)")
                    .frame(maxWidth: .infinity)
                    .background(Color.cyan)
            }
//            Text("test")
//                .padding(.horizontal)
//                .background(Color.gray)
//            Text("fewafe")
//                .padding(.horizontal)
//                .background(Color.gray)
//            Text("awvmeokwmcoe")
//                .padding(.horizontal)
//                .background(Color.gray)
        }
        .background(Color.blue)
    }
}

#Preview {
    ProfileEditorView()
}
