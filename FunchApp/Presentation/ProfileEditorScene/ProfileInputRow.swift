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
    
    /// 좌측 Text()의 ViewType 별로 높이 값
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
//            var selectedMBTI: [String] = .init(repeating: String(), count: 4)
            /// Profile.MBTI에 적용될 값들입니다. 각각 쌍으로 매칭해두었습니다.
            // FIXME: 나중에 다른 곳에 빼두면 좋을 것 같아요
//            let mbtiPairData: [[String]] = [["E", "I"], ["N", "S"], ["F", "T"], ["P", "J"]]
//            DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
//                ForEach(0..<4) { pairIndex in
//                    ProfileMBTIButtonPair(onTap: { index in
//                        selectedMBTI[pairIndex] = mbtiPairData[pairIndex][index]
//                        // action
//                        print(selectedMBTI)
//                    }, dataPair: mbtiPairData[pairIndex])
//                }
//            }
            
        case .혈액형:
            bloodTypeInputField
            
        case .지하철:
            subwayInputField
        }
    }
}

extension ProfileInputRow {
    @ViewBuilder
    private var nicknameInputField: some View {
        FunchTextField(text: $profile.userNickname,
                       placeholderText: "최대 9글자", textLimit: 9)
    }
    
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
                        print(profile.clubs)
                    },
                    title: club.name,
                    imageName: club.imageName,
                    isSelected: selectedClub.contains(club)
                )
            }
        }
    }
    
    @ViewBuilder
    private var mbtiInputField: some View {
        ProfileMBTIButtonSet(selectedMBTI: $profile.mbti)
    }
    
    @ViewBuilder
    private var bloodTypeInputField: some View {
        Text("test")
    }
    
    @ViewBuilder
    private var subwayInputField: some View {
        /// 지하철 검색하면 받아와지는 유사 지하철역 이름 리스트
        let subwayRecommendation: [SubwayInfo] = [.testableValue, .testableValue]
        Text("test")
    }
}



struct ChipButton: View {
    
    enum ViewType {
        /// 텍스트
        case text
        /// 이미지 + 텍스트
        case image
    }
    
    /// 어떤 view인지에 따른 가로 padding
    private var verticalPadding: CGFloat {
        switch type {
        case .text: 12
        case .image: 8
        }
    }
    
    /// 어떤 view인지에 따른 세로 padding
    private var horizontalPadding: CGFloat {
        switch type {
        case .text: 16
        case .image: 8
        }
    }
    
    
    /// 칩 뷰 타입
    private(set) var type: ViewType
    
    init(action: @escaping () -> Void,
//         isSelected: Binding<Bool>,
         title: String,
         imageName: String? = nil,
         isSelected: Bool
    ) {
        self.action = action
//        self._isSelected = isSelected
        self.title = title
        self.isSelected = isSelected
        
        if let imageName = imageName {
            self.type = .image
            self.imageName = imageName
        } else {
            self.type = .text
            self.imageName = ""
        }
    }
    
    /// 터치 액션
    var action: () -> Void
    /// 선택됐는지를 나타내는 State
    var isSelected: Bool
//    @Binding private var isSelected: Bool
    /// 타이틀
    var title: String = ""
    /// 리소스 이름
    var imageName: String = ""
    
    
    var body: some View {
        Button {
            action()
        } label: {
            buttonInnerView
        }
        .tint(.white)
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
        .padding(.trailing, type == .image ? 8 : 0)
        .background(isSelected ? .gray500 : .gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private var buttonInnerView: some View {
        switch type {
        case .text:
            Text(title)
                .foregroundStyle(isSelected ? .white : .gray400)
                .customFont(.subtitle2)
                .frame(width: 16, height: 24)
            
        case .image:
            HStack {
                VStack {
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                .frame(width: 32, height: 32)
                .background(.gray900)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(title)
                    .foregroundStyle(isSelected ? .white : .gray400)
                    .customFont(.body)
            }
        }
    }
}


#Preview {
    NavigationStack {
        ProfileEditorView()
    }
}
