//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileEditorView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var viewModel: ProfileEditorViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray900
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Spacer()
                            .frame(height: 8)
                        
                        Text("프로필 만들기")
                            .foregroundColor(.white)
                            .customFont(.title2)
                        
                        Spacer()
                            .frame(height: 2)
                        
                        Text("프로필을 바탕으로 매칭을 도와드려요")
                            .foregroundColor(.gray300)
                            .customFont(.body)
                        
                        profileInputFields
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                    .frame(height: 0)
                    .keyboardBottomPadding(defaultHeight: UIDevice.current.hasNotch ? 114 : 96)
            }
            
            VStack(spacing: 0) {
                Spacer()
                matchingButtonView
            }
        }
        .onTapGesture {
            viewModel.send(action: .focusField(nil))
        }
        .onReceive(viewModel.$focusedField) { focusField in
            switch focusField {
            case .nickname, .subway: break
            default:
                DispatchQueue.main.async {
                    hideKeyboard()
                }
            }
        }
        .onReceive(viewModel.$presentation) {
            switch $0 {
            case .home:
                dismiss()
            default:
                break
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(.iconArrowBack)
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.send(action: .feedback)
                } label: {
                    Text("피드백 보내기")
                        .foregroundColor(.white)
                        .customFont(.body)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.gray800)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
            }
        }
        .toolbarBackground(Color.gray900, for: .navigationBar)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var matchingButtonView: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 16)
                
                Button {
                    viewModel.send(action: .makeProfile)
                } label: {
                    Text("이제 매칭할래요!")
                        .foregroundColor(.gray900)
                        .customFont(.subtitle1)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultFunchButtonStyle(isEnabled: viewModel.isEnabled))
                .shadow(color: viewModel.isEnabled ? .lemon500.opacity(0.7) : .clear, radius: 4, x: 0, y: 4)
                .disabled(!viewModel.isEnabled)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
        .frame(height: UIDevice.current.hasNotch ? 114 : 96)
        .background(.gray900)
    }
}


extension ProfileEditorView {
    
    private func profileInputRow(
        type: String,
        labelHeight: CGFloat,
        inputField: some View
    ) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(type)
                .foregroundColor(.gray300)
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
            text: $viewModel.userNickname,
            placeholderText: "최대 9글자",
            textLimit: 9
        )
        .onTapGesture {
            viewModel.send(action: .focusField(.nickname))
        }
        .onChange(of: viewModel.userNickname, perform: { _ in
            viewModel.send(action: .onChangeProfile)
        })
    }
    
    
    private var majorInputField: some View {
        DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Major.dummies, id: \.self) { major in
                ChipButton(
                    action: {
                        viewModel.send(action: .inputProfile(.major(major)))
                    },
                    title: major.name,
                    imageName: major.imageName,
                    isSelected: viewModel.majors.contains(major)
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
                    isSelected: viewModel.clubs.contains(club)
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
                            isSelected: viewModel.mbti.contains(Profile.mbtiPair[pairIndex][letterIndex])
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
                    viewModel.send(action: .focusField(nil))
                } label: {
                    Text(bloodType)
                }
            }
        } label: {
            HStack(spacing: 0) {
                Text(viewModel.bloodType + "형")
                    .font(.Funch.body)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
        }
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            if viewModel.focusedField == .bloodType {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white, lineWidth: 1)
            }
        }
        .onTapGesture {
            viewModel.send(action: .focusField(.bloodType))
        }
    }
    
    
    private var subwayInputField: some View {
        VStack(spacing: 0) {
            FunchTextField(
                text: $viewModel.subwaySearchText,
                placeholderText: "가까운 지하철역 검색",
                leadingImage: .init(systemName: "magnifyingglass"),
                onSubmit: {
                    viewModel.send(action: .subwaySearch)
                }
            )
            .onTapGesture {
                viewModel.send(action: .focusField(.subway))
            }
            
            Spacer()
                .frame(height: 4)
            
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    ForEach(viewModel.searchedSubwayInfo, id: \.self) { subwayInfo in
                        Button {
                            viewModel.send(action: .inputProfile(.subway(subwayInfo)))
                            viewModel.send(action: .focusField(nil))
                        } label: {
                            Text(subwayInfo.name.applyColorToText(target: viewModel.subwaySearchText, color: .white) ?? AttributedString(subwayInfo.name))
                                .font(.Funch.body)
                                .foregroundColor(.gray500)
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
    
}


