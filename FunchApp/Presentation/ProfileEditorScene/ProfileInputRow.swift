//
//  ProfileInputRow.swift
//  FunchApp
//
//  Created by 이성민 on 1/22/24.
//

import SwiftUI

extension ProfileEditorView {
    
    private func profileInputRow(
        type: String,
        labelHeight: CGFloat,
        inputField: some View
    ) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(type)
                .foregroundStyle(.gray300)
                .customFont(.body)
                .frame(width: 52, height: 56, alignment: .leading)
            
            inputField
        }
    }
    
    
    var profileInputFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            profileInputRow(type: "닉네임", labelHeight: 56, inputField: userNicknameInputField)
            
            Spacer()
                .frame(height: 36)
            
            VStack(alignment: .leading, spacing: 16) {
                profileInputRow(type: "직군", labelHeight: 52, inputField: majorInputField)
                profileInputRow(type: "동아리", labelHeight: 52, inputField: clubsInputField)
                profileInputRow(type: "MBTI", labelHeight: 52, inputField: mbtiInputField)
                profileInputRow(type: "혈액형", labelHeight: 56, inputField: bloodTypeInputField)
                profileInputRow(type: "지하철", labelHeight: 56, inputField: subwayInputField)
            }
        }
        .padding(.vertical, 24)
    }
    
    
    private var userNicknameInputField: some View {
        FunchTextField(
            text: $viewModel.state.userNickname,
            placeholderText: "최대 9글자",
            textLimit: 9
        )
    }
    
    
    private var majorInputField: some View {
        DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Major.dummies, id: \.self) { major in
                ChipButton(
                    action: {
                        viewModel.state.majors = [major]
                    },
                    title: major.name,
                    imageName: major.imageName,
                    isSelected: viewModel.state.majors.contains(major)
                )
            }
        }
    }
    
    
    private var clubsInputField: some View {
        DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Club.dummies, id: \.self) { club in
                ChipButton(
                    action: {
                        viewModel.send(action: .inputProfile(.clubs(club)))
                    },
                    title: club.name,
                    imageName: club.imageName,
                    isSelected: viewModel.state.clubs.contains(club)
                )
            }
        }
    }
    
    
    private var mbtiInputField: some View {
        HStack(alignment: .top, spacing: 8){
            ForEach(0..<4, id: \.self) { pairIndex in
                VStack(spacing: 0) {
                    ForEach(0..<2, id: \.self) { letterIndex in
                        ChipButton(
                            action: {
                                viewModel.send(action: .inputProfile(.mbti([pairIndex, letterIndex])))
                            },
                            title: Profile.mbtiPair[pairIndex][letterIndex],
                            isSelected: viewModel.state.mbti.contains(Profile.mbtiPair[pairIndex][letterIndex])
                        )
                    }
                }
                .background(.gray800)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    
    @ViewBuilder
    private var bloodTypeInputField: some View {
        let bloodTypes: [String] = ["A", "B", "AB", "O"]
        
        Menu {
            ForEach(bloodTypes, id: \.self) { bloodType in
                Button {
                    viewModel.send(action: .inputProfile(.bloodType(bloodType)))
                } label: {
                    Text(bloodType)
                }
            }
        } label: {
            HStack(spacing: 0) {
                Text(viewModel.state.bloodType)
                    .font(.Funch.body)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
        }
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            if focused == .bloodType {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white, lineWidth: 1)
            }
        }
        .focused($focused, equals: .bloodType)
    }
    
    
    private var subwayInputField: some View {
        VStack(spacing: 0) {
            FunchTextField(
                text: $viewModel.state.subwaySearchText,
                placeholderText: "가까운 지하철역 검색",
                leadingImage: .init(systemName: "magnifyingglass"),
                onSubmit: {
                    viewModel.send(action: .subwaySearch)
                }
            )
            
            Spacer()
                .frame(height: 4)
            
            HStack(spacing: 4) {
                ForEach(viewModel.state.searchedSubwayInfo, id: \.self) { subwayInfo in
                    Button {
                        viewModel.send(action: .inputProfile(.subway(subwayInfo)))
                    } label: {
                        Text(subwayInfo.name.applyColorToText(target: viewModel.state.subwaySearchText, color: .white) ?? AttributedString(subwayInfo.name))
                            .font(.Funch.body)
                            .foregroundStyle(.gray500)
                    }
                    .padding(8)
                    .background(.gray800)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                Spacer()
            }
        }
    }
    
}

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
    /// 지하철 검색 Action
    private var tappedButton: () -> Void
    
    init(type: ViewType, profile: Binding<Profile>, tappedButton: @escaping () -> Void = {}) {
        self.type = type
        self._profile = profile
        self.tappedButton = tappedButton
    }
    
    @EnvironmentObject var parent: ProfileEditorViewModel
    @State var subwayInputText: String = ""
    
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
    private var mbtiInputField: some View {
        ProfileMBTIButtonSet(selectedMBTI: $profile.mbti)
    }
    
    /// 혈액형 입력용 Input Field
    @ViewBuilder
    private var bloodTypeInputField: some View {
        let bloodTypes = ["A", "B", "AB", "O"]
        let bloodTypeInStrings = bloodTypes.map { type in type + "형" }
        FunchDropDownMenu(selectedData: $profile.bloodType, data: bloodTypeInStrings)
    }
    
    /// 지하철 입력용 Input Field
    @ViewBuilder
    private var subwayInputField: some View {
        /// 지하철 검색하면 받아와지는 유사 지하철역 이름 리스트
        let subwayRecommendation: [SubwayInfo] = [.testableValue]
        
        VStack(spacing: 0) {
            // FIXME: profile editor model 도 넣으면 좋을듯 -> 이 텍스트필드에 subwayInfo로 접근이 불가능
            FunchTextField(
                text: $subwayInputText,
                placeholderText: "가까운 지하철역 검색",
                leadingImage: .init(systemName: "magnifyingglass"),
                onButtonTap: {
                    tappedButton()
                }
            )
            
            Spacer()
                .frame(height: 4)
            
            HStack(spacing: 4) {
                ForEach(subwayRecommendation, id: \.self) { subwayInfo in
                    Button {
                        profile.subwayInfos = [subwayInfo]
                        subwayInputText = subwayInfo.name
                    } label: {
                        Text(subwayInfo.name.applyColorToText(target: subwayInputText, color: .white) ?? AttributedString(subwayInfo.name))
                            .font(.Funch.body)
                            .foregroundStyle(.gray500)
                    }
                    .padding(8)
                    .background(.gray800)
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
