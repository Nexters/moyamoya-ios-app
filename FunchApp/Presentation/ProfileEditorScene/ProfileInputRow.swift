//
//  ProfileInputRow.swift
//  FunchApp
//
//  Created by 이성민 on 1/22/24.
//

import SwiftUI

struct ProfileInputRow: View {
    
    enum ViewType: String {
        case 닉네임
        case 직군
        case 동아리
        case MBTI
        case 혈액형
        case 지하철
    }
    
    /// 좌측 Text()의 ViewType 별 높이 값
    private var leadingTextHeight: CGFloat {
        switch type {
        case .닉네임, .혈액형, .지하철:
            return 56
        case .직군, .동아리, .MBTI:
            return 48
        }
    }
    
    /// 입력받을 값들의 종류
    private(set) var type: ViewType
    /// 입력받는 Profile
    @Binding private(set) var profile: Profile
    
    init(type: ViewType, profile: Binding<Profile>) {
        self.type = type
        self._profile = profile
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(type.rawValue)
                .foregroundStyle(.gray300)
                .customFont(.body)
                .frame(width: 52, height: leadingTextHeight, alignment: .leading)
            
            inputView
        }
    }
    
    @ViewBuilder
    private var inputView: some View {
        switch type {
        case .닉네임:
            nicknameInputField
            
        case .직군:
            majorInputField
            
        case .동아리:
            clubInputField
            
        case .MBTI:
            mbtiInputField
            
        case .혈액형:
            bloodTypeInputField
            
        case .지하철:
            subwayInputField
        }
    }
}

extension ProfileInputRow {
    /// 닉네임 입력용 Input Field
    @ViewBuilder
    private var nicknameInputField: some View {
        FunchTextField(text: $profile.userNickname,
                       placeholderText: "최대 9글자",
                       textLimit: 9)
    }
    
    /// 직업 입력용 Input Field
    @ViewBuilder
    private var majorInputField: some View {
        var selectedMajor: [Profile.Major] = profile.majors
        
        DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Major.dummies, id: \.self) { major in
                ChipButton(
                    action: {
                        if selectedMajor.isEmpty { selectedMajor.append(major) }
                        else {
                            selectedMajor.removeAll()
                            selectedMajor.append(major)
                        }
                        profile.majors = selectedMajor
                    },
                    title: major.name,
                    imageName: major.imageName,
                    isSelected: selectedMajor.contains(major)
                )
            }
        }
    }
    
    /// 동아리 입력용 Input Field
    @ViewBuilder
    private var clubInputField: some View {
        var selectedClub: Set<Profile.Club> = Set(profile.clubs)
        
        DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Club.dummies, id: \.self) { club in
                ChipButton(
                    action: {
                        if selectedClub.contains(club) { selectedClub.remove(club) }
                        else { selectedClub.insert(club) }
                        profile.clubs = Array(selectedClub)
                    },
                    title: club.name,
                    imageName: club.imageName,
                    isSelected: selectedClub.contains(club)
                )
            }
        }
    }
    
    /// MBTI 입력용 Input Field
    @ViewBuilder
    private var mbtiInputField: some View {
        ProfileMBTIButtonSet(selectedMBTI: $profile.mbti)
    }
    
    /// 혈액형 입력용 Input Field
    @ViewBuilder
    private var bloodTypeInputField: some View {
        Text("test")
    }
    
    /// 지하철 입력용 Input Field
    @ViewBuilder
    private var subwayInputField: some View {
        /// 지하철 검색하면 받아와지는 유사 지하철역 이름 리스트
        let subwayRecommendation: [SubwayInfo] = [.testableValue]
        
        VStack(spacing: 0) {
            // FIXME: profile editor model 도 넣으면 좋을듯 -> 이 텍스트필드에 subwayInfo로 접근이 불가능
            FunchTextField(
                onChangeAction: { oldText, newText in
                    // action
                },
                text: $profile.userCode,
                placeholderText: "가까운 지하철역 검색",
                leadingImage: .init(systemName: "magnifyingglass")
            )
            
            Spacer()
                .frame(height: 4)
            
            HStack(spacing: 4) {
                ForEach(subwayRecommendation, id: \.self) { subwayInfo in
                    Text(subwayInfo.name)
                        .font(.Funch.body)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.gray500)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileEditorView()
    }
}
