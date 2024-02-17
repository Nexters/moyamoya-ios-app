//
//  MatchResultView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI
import SwiftUIPager

struct MatchResultView: View {
    /// 매칭 결과물
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
                            
                            Spacer()
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
            }
        }
    }
    
    /// pageIndex에 따른 결과 View
    @ViewBuilder
    private func resultView(_ pageIndex: Int) -> some View {
        switch pageIndex {
        case 0: synergyView
        case 1: recommendationView
        case 2: profileView(matchResult.profile)
        default: EmptyView()
        }
    }
    
    /// 몇 번째 페이지인지 나타내는 index label
    private func pageIndexLabel(_ index: Int) -> some View {
        HStack(spacing: 0) {
            Text("\(index + 1)")
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
    
    /// 시너지 정보를 보여주는 View
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
            
            Image(.findSynergyImageResource(from: matchResult.similarity))
                .resizable()
                .frame(minWidth: 136, maxWidth: 200, minHeight: 136, maxHeight: 200)
            
            Spacer()
                .frame(height: 16)
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(matchResult.chemistryInfos, id: \.self) { info in
                    ChemistryLabel(info: info)
                }
            }
        }
    }
    
    // FIXME: 나중에 옮기면 좋을듯
    /// 추천 대화 주제 리스트
    private let recommendationList: [String] = [
        "어느 팀이세요?",
        "팀에서 어떤 서비스를 만드나요?",
        "서로의 첫인상은?",
        "가장 인상 깊었던 여행지는?",
        "취미를 소개해주세요!"
    ]
    /// 대화 주제 추천해주는 View
    private var recommendationView: some View {
        VStack(spacing: 0) {
            Text("우리 이런 주제로 대화해봐요")
                .font(.Funch.title2)
                .foregroundStyle(.white)
            
            Spacer()
                .frame(height: 4)
            
            Text("지금부터 서로에게 집중하는 시간!")
                .font(.Funch.body)
                .foregroundStyle(.gray300)
            
            VStack(spacing: 8) {
                ForEach(recommendationList, id: \.self) { recommendationText in
                    ChipView(title: recommendationText)
                }
            }
            .frame(maxHeight: .infinity)
            
            Spacer()
                .frame(height: 16)
        }
    }
    
    /// 상대방의 프로필을 보여주는 View
    @ViewBuilder
    private func profileView(_ matchResult: MatchingInfo.MatchProfile) -> some View {
        let profile: ProfileChipRow.ProfileRowInfo = .init(major: matchResult.major,
                                                           clubs: matchResult.clubs,
                                                           mbti: matchResult.mbti,
                                                           bloodType: matchResult.bloodType,
                                                           subwayInfos: matchResult.subwayNames)
        Text(matchResult.name)
            .font(.Funch.title2)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
            .frame(height: 20)
        
        VStack(alignment: .leading, spacing: 16) {
            ProfileChipRow(.직군, profile, isHighlighted: true)
            ProfileChipRow(.동아리, profile, isHighlighted: false)
            ProfileChipRow(.MBTI, profile, isHighlighted: false)
            ProfileChipRow(.혈액형, profile, isHighlighted: true)
            ProfileChipRow(.지하철, profile, isHighlighted: false)
        }
    }
}

#Preview {
    NavigationStack {
        MatchResultView()
    }
}
