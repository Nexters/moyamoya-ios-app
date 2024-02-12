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
    
    /// 행의 좌측에 붙는 타이틀
    private(set) var type: ViewType
    /// 프로필
    private(set) var profile: Profile
    /// 매치 결과에 따라 하이라이트 여부
    private(set) var isHighlighted: Bool
    
    init(_ type: ViewType, _ profile: Profile, isHighlighted: Bool = false) {
        self.type = type
        self.profile = profile
        self.isHighlighted = isHighlighted
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(type.rawValue)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .font(.Funch.body)
                .foregroundStyle(.gray400)
                .frame(width: 52, alignment: .leading)
            
            flexibleChipView
                .highlight(isHighlighted)
            
            Spacer()
        }
    }
    
    /// 타입에 따른 칩뷰 영역
    private var flexibleChipView: some View {
        switch type {
        case .직군:
            let major = profile.majors
                .map { $0 }
                .first!
            return ChipView(title: major.name, imageName: major.imageName)
        case .동아리:
            let club = profile.clubs
                .map { $0 }
                .first!
            return ChipView(title: club.name, imageName: club.imageName)
        case .MBTI:
            let mbti = profile.mbti
            return ChipView(title: mbti)
        case .혈액형:
            let bloodType = profile.bloodType + "형"
            return ChipView(title: bloodType)
        case .지하철:
            let subwayName = profile.subwayInfos
                .map { $0.name }
                .first ?? ""
            return ChipView(title: subwayName)
        }
    }
}
