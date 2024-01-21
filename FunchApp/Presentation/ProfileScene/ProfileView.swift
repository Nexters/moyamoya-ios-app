//
//  ProfileView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    let profile: Profile = .testableValue
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 8)
            VStack(alignment: .leading, spacing: 20) {
                Text("USERCODE")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
                
                Text("동대문역사문화공원역")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.68, green: 0.68, blue: 0.68))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                ProfileChipRow(.직군, .testableValue)
                ProfileChipRow(.동아리, .testableValue)
                ProfileChipRow(.MBTI, .testableValue)
                ProfileChipRow(.별자리, .testableValue)
                ProfileChipRow(.지하철, .testableValue)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            .frame(width: 320, alignment: .center)
            .background(.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 1)
            )
            
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
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}

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
            
            // TODO: - 성민이 아이템으로 교체
//            ChipView(title: "Nexters", imageName: "")
            
            flexibleChipView
            
            Spacer()
        }
    }
    
    private var flexibleChipView: some View {
        switch type {
        case .직군:
            let major = profile.major
                .compactMap { $0 }
                .map { $0 }
                .first!
            return ChipView(title: major.name, imageName: major.imageName)
        case .동아리:
            let club = profile.club
                .compactMap { $0 }
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
