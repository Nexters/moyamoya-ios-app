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
        case 별자리
        case 지하철
    }
    
    /// 행의 좌측에 붙는 타이틀
    private(set) var type: ViewType
    /// 프로필
    private(set) var profile: Profile
    
    init(_ type: ViewType, _ profile: Profile) {
        self.type = type
        self.profile = profile
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(type.rawValue)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                .frame(width: 52, alignment: .leading)
            
            flexibleChipView
            
            Spacer()
        }
    }
    
    /// 타입에 따른 칩뷰 영역
    private var flexibleChipView: some View {
        switch type {
        case .직군:
            let major = profile.major
                .map { $0 }
                .first!
            return ChipView(title: major.name, imageName: major.imageName)
        case .동아리:
            let club = profile.club
                .map { $0 }
                .first!
            return ChipView(title: club.name, imageName: club.imageName)
        case .MBTI:
            let mbti = profile.mbti
            return ChipView(title: mbti)
        case .별자리:
            let constellation = profile.constellation
            return ChipView(title: constellation)
        case .지하철:
            let subwayName = profile.subwayName
            return ChipView(title: subwayName)
        }
    }
}
