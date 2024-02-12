//
//  MatchResultView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI
import SwiftUIPager

struct MatchResultView: View {
    
    let matchResult: MatchingInfo
    
    init(matchResult: MatchingInfo = .testableValue) {
        self.matchResult = matchResult
    }
    
    @StateObject var page: Page = .first()
    private var viewSize: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Pager(page: page, data: 0..<3, id: \.self) { pageIndex in
                    ZStack {
                        Color.gray800
                        
                        VStack(spacing: 0) {
                            pageIndexLabel(pageIndex)
                            
                            Spacer()
                                .frame(height: 8)
                            
                            resultView(pageIndex)
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 28)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .horizontal()
                .singlePagination(ratio: 0.33, sensitivity: .custom(0.2))
                .preferredItemSize(.init(width: viewSize.width * 0.9, height: viewSize.height))
                .itemSpacing(8)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func resultView(_ pageIndex: Int) -> some View {
        switch pageIndex {
        case 0: synergyView
        case 1: recommendationView
        case 2: profileView
        default: EmptyView()
        }
    }
    
    private var synergyView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("우리는 ")
                    .foregroundStyle(.white)
                Text("\(matchResult.similarity)%")
                    .foregroundStyle(Gradient.funchGradient(type: .lemon500))
                Text(" 닮았어요")
                    .foregroundStyle(.white)
            }
            .font(.Funch.title2)
            
            Spacer()
                .frame(height: 16)
            
            Image(.iconInformation)
                .resizable()
                .frame(width: 136, height: 136)
            
            Spacer()
                .frame(height: 16)
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(matchResult.synergyInfos, id: \.self) { info in
                    SynergyLabel(info: info)
                }
            }
            
            Spacer()
        }
    }
    
    private var recommendationView: some View {
        VStack(spacing: 0) {
            
        }
    }
    
    private var profileView: some View {
        VStack(spacing: 0) {
            
        }
    }
    
    
    private func pageIndexLabel(_ index: Int) -> some View {
        HStack(spacing: 0) {
            Text("\(index)")
                .foregroundStyle(.white)
            Text("/3")
                .foregroundStyle(.gray400)
        }
        .font(.Funch.caption)
        .padding(.vertical, 2)
        .padding(.horizontal, 8)
        .background(.gray500)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    NavigationStack {
        MatchResultView()
    }
}
