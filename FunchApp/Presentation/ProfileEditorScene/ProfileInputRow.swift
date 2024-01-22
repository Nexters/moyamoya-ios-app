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
        case 생일
        case 지하철
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
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                .frame(width: 52, height: leadingTextHeight, alignment: .leading)
            
            inputView
        }
    }
    
    /// 좌측 Text()의 ViewType 별로 높이 값
    private var leadingTextHeight: CGFloat {
        switch type {
        case .닉네임, .생일, .지하철:
            return 56
        case .직군, .동아리, .MBTI:
            return 48
        }
    }
    
    @ViewBuilder
    private var inputView: some View {
        switch type {
        case .닉네임:
            FunchTextField(text: $profile.userNickname,
                           placeholderText: "최대 00글자")
            
        case .직군:
            DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
                ForEach(Profile.Major.dummies, id: \.self) { major in
                    Button {
                        if profile.major.isEmpty { profile.major.append(major) }
                        else { profile.major[0] = major }
                        // action
                        print(profile.major)
                    } label: {
                        ChipView(title: major.name,
                                 imageName: major.imageName,
                                 isSelected: profile.major.contains(major))
                    }
                    .foregroundStyle(profile.major.contains(major) ? Color.black : Color.gray)
                    .background(profile.major.contains(major) ? Color.gray : Color.clear)
                    .buttonStyle(.noEffect)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            
        case .동아리:
            var selectedClubs: Set<Profile.Club> = Set()
            DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
                ForEach(Profile.Club.dummies, id: \.self) { club in
                    Button {
                        if selectedClubs.contains(club) { selectedClubs.remove(club) }
                        else { selectedClubs.insert(club) }
                        profile.club = Array(selectedClubs)
                        // action
                        print(profile.club)
                    } label: {
                        ChipView(title: club.name,
                                 imageName: club.imageName,
                                 isSelected: profile.club.contains(club))
                    }
                    .foregroundStyle(profile.club.contains(club) ? Color.black : Color.gray)
                    .background(profile.club.contains(club) ? Color.gray : Color.clear)
                    .buttonStyle(.noEffect)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            
        case .MBTI:
            var selectedMBTI: [String] = .init(repeating: String(), count: 4)
            let mbtiPairData: [[String]] = [["E", "I"], ["N", "S"], ["F", "T"], ["P", "J"]]
            DynamicHGrid(itemSpacing: 8, lineSpacing: 8) {
                ForEach(0..<4) { i in
                    ProfileMBTIButtonPair(onTap: { index in
                        selectedMBTI[i] = mbtiPairData[i][index]
                        // action
                        print(selectedMBTI)
                    }, dataPair: mbtiPairData[i])
                }
            }
            
        case .생일:
            VStack(spacing: 0) {
                FunchTextField(text: $profile.birth,
                               placeholderText: "생년월일 6자리 (ex: 991114)")
                .keyboardType(.numberPad)
                .onChange(of: profile.birth) { _, newValue in /* action */ }
                .onSubmit { /* action */ }
                
                Spacer()
                    .frame(height: 4)
                
                HStack(spacing: 0) {
                    Spacer()
                        .frame(width: 8)
                    
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(red: 0.73, green: 0.73, blue: 0.73))
                    
                    Spacer()
                        .frame(width: 4)
                    
                    Text("나이는 상대에게 공개되지 않아요")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.73, green: 0.73, blue: 0.73))
                    
                    Spacer()
                }
            }
            
        case .지하철:
            /// 지하철 검색하면 받아와지는 유사 지하철역 이름 리스트
            var subwayRecommendation: [SubwayName] = [.init(name: "test")]
            
            VStack(spacing: 0) {
                FunchTextField(text: $profile.subwayName,
                               placeholderText: "지하철",
                               leadingImage: Image(systemName: "magnifyingglass"))
                .onChange(of: profile.subwayName) { _, newValue in
                    /* action */
                    subwayRecommendation.append(.init(name: newValue))
                    print(subwayRecommendation)
                }
                
                Spacer()
                    .frame(height: 8)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(subwayRecommendation, id: \.self) { subway in
                            Button {
                                print(subway.name)
                                profile.subwayName = subway.name
                            } label: {
                                Text(subway.name)
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.black)
                                    .padding(8)
                            }
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

struct SubwayName: Hashable { var name: String }
