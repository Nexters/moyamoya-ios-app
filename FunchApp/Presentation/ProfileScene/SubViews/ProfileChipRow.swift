//
//  ProfileChipRow.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import SwiftUI

struct ProfileChipRow: View {
    
    enum ViewType: String {
        case 직군
        case 동아리
        case MBTI
        case 혈액형
        case 지하철
    }
    
    struct ProfileRowInfo {
        let major: String
        let clubs: [String]
        let mbti: String
        let bloodType: String
        let subwayInfos: [String]
    }
    
    /// 행의 좌측에 붙는 타이틀
    private(set) var type: ViewType
    /// 프로필
    private(set) var profile: ProfileRowInfo
    /// 매치 결과에 따라 하이라이트 여부
    private(set) var isHighlighted: Bool
    
    init(_ type: ViewType, _ profile: ProfileRowInfo, isHighlighted: Bool = false) {
        self.type = type
        self.profile = profile
        self.isHighlighted = isHighlighted
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(type.rawValue)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .font(.Funch.body)
                .foregroundStyle(.gray400)
                .frame(width: 52, height: 48, alignment: .leading)
            
            flexibleChipView
                .highlight(isHighlighted)
            
            Spacer()
        }
    }
    
    /// 타입에 따른 칩뷰 영역
    @ViewBuilder
    private var flexibleChipView: some View {
        switch type {
        case .직군:
            ChipView(title: profile.major, imageName: profile.major)
        case .동아리:
            let clubs = profile.clubs
            DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
                ForEach(clubs, id: \.self) { club in
                    ChipView(title: club, imageName: club)
                }
            }
        case .MBTI:
            let mbti = profile.mbti
            ChipView(title: mbti)
        case .혈액형:
            let bloodType = profile.bloodType + "형"
            ChipView(title: bloodType)
        case .지하철:
            let subways = profile.subwayInfos
            HStack(spacing: 8) {
                ForEach(subways, id: \.self) { subwayName in
                    ChipView(title: subwayName)
                }
            }
        }
    }
}
