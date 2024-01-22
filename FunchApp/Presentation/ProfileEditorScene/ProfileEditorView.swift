//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileEditorView: View {
    
    @State var profile: Profile = .testableValue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("프로필 만들기")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text("프로필을 바탕으로 매칭을 도와드려요")
                    .font(.system(size: 14))
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("닉네임")
                            .font(.system(size: 14))
                            .frame(width: 52, alignment: .leading)
                        
                        FunchTextField(text: $profile.userNickname,
                                       placeholderText: "최대 00글자")
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("직군")
                            .font(.system(size: 14))
                            .frame(width: 52, alignment: .leading)
                        
                        jobSelectionView
                    }
                    
                    HStack(alignment: .top, spacing: 0) {
                        Text("동아리")
                            .font(.system(size: 14))
                            .frame(width: 52, height: 48, alignment: .leading)
                        
                        clubSelectionView
                    }
                    
                    HStack(alignment: .top, spacing: 0) {
                        Text("MBTI")
                            .font(.system(size: 14))
                            .frame(width: 52, height: 48, alignment: .leading)
                        
                        mbtiSelectionView
                    }
                    
                    HStack(alignment: .top, spacing: 0) {
                        Text("생일")
                            .font(.system(size: 14))
                            .frame(width: 52, height: 56, alignment: .leading)
                        
                        birthInputField
                    }
                    
                    HStack(alignment: .top, spacing: 0) {
                        Text("지하철")
                            .font(.system(size: 14))
                            .frame(width: 52, height: 56, alignment: .leading)
                        
                        subwayInputField
                    }
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 0.84, green: 0.84, blue: 0.84), lineWidth: 1)
                }
                
                Spacer()
                    .frame(height: 24)
                
                Button {
                    /* action */
                } label: {
                    Text("이제 매칭할래요!")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .frame(height: 32)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.funch)
            }
            .padding(.horizontal, 20)
        }
    }
    
    
    @State var selectedJobs: Profile.Major?
    private var jobSelectionView: some View {
        HStack(spacing: 8) {
            ForEach(Profile.Major.dummies, id: \.self) { major in
                Button {
                    self.selectedJobs = major
                    // action
                    print(selectedJobs)
                } label: {
                    ChipView(title: major.name,
                             imageName: major.imageName,
                             isSelected: selectedJobs == major)
                }
                .foregroundStyle(selectedJobs == major ? Color.black : Color.gray)
                .background(selectedJobs == major ? Color.gray : Color.clear)
                .buttonStyle(.noEffect)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    
    @State var selectedClubs: Set<Profile.Club> = Set()
    private var clubSelectionView: some View {
        FlowLayoutGrid(alignment: .leading, itemSpacing: 8, lineSpacing: 8) {
            ForEach(Profile.Club.dummies, id: \.self) { club in
                Button {
                    if selectedClubs.contains(club) { selectedClubs.remove(club) }
                    else { selectedClubs.insert(club) }
                    // action
                    print(selectedClubs)
                } label: {
                    ChipView(title: club.name,
                             imageName: club.imageName,
                             isSelected: selectedClubs.contains(club))
                }
                .foregroundStyle(selectedClubs.contains(club) ? Color.black : Color.gray)
                .background(selectedClubs.contains(club) ? Color.gray : Color.clear)
                .buttonStyle(.noEffect)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    
    @State var selectedMBTI: [String] = .init(repeating: String(), count: 4)
    let mbtiPairData: [[String]] = [["E", "I"], ["N", "S"], ["F", "T"], ["P", "J"]]
    private var mbtiSelectionView: some View {
        HStack(spacing: 8) {
            ForEach(0..<4) { i in
                ProfileMBTIButtonPair(onTap: { index in
                    selectedMBTI[i] = mbtiPairData[i][index]
                    // action
                    print(selectedMBTI)
                }, dataPair: mbtiPairData[i])
            }
        }
    }
    
    
    private var birthInputField: some View {
        VStack(alignment: .leading) {
            FunchTextField(text: $profile.birth,
                           placeholderText: "생년월일 6자리 (ex: 991114)")
            .keyboardType(.numberPad)
            .onChange(of: profile.birth) { _, newValue in
                // action
            }
            .onSubmit {
                // action
            }
            
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
    }
    
    struct SubwayName: Hashable { var name: String }
    @State var subwayRecommendation: [SubwayName] = [.init(name: "test")]
    private var subwayInputField: some View {
        VStack(alignment: .leading) {
            FunchTextField(text: $profile.subwayName,
                           placeholderText: "지하철",
                           leadingImage: Image(systemName: "magnifyingglass"))
            .onChange(of: profile.subwayName) { _, newValue in
                // action
                subwayRecommendation.append(.init(name: newValue))
                print(subwayRecommendation)
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(subwayRecommendation, id: \.self) { subway in
                        Button {
                            print(subway.name)
                            profile.subwayName = subway.name
                        } label: {
                            Text(subway.name)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
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

#Preview {
    ProfileEditorView()
}

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: 0, y: 0))
        path.addLine(to: .init(x: rect.width, y: 0))
        return path
    }
}
