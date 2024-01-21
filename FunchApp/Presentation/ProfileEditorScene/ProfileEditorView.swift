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
                    
                    FunchTextField(onSubmit: { /* action */ },
                                   bindingText: $profile.userNickname,
                                   placeholder: "test",
                                   rightImage: Image(systemName: "magnifyingglass"))
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
                    
                    HStack(spacing: 8) {
                        ProfileMBTIButtonPair(onTap: { selected in /* action */ },
                                              dataPair: ["E", "I"])
                        ProfileMBTIButtonPair(onTap: { selected in /* action */ },
                                              dataPair: ["N", "S"])
                        ProfileMBTIButtonPair(onTap: { selected in  /* action */ },
                                              dataPair: ["F", "T"])
                        ProfileMBTIButtonPair(onTap: { selected in  /* action */ },
                                              dataPair: ["P", "J"])
                    }
                }
                
                HStack(alignment: .top, spacing: 0) {
                    Text("생일")
                        .font(.system(size: 14))
                        .frame(width: 52, height: 56, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        FunchTextField(onSubmit: { /* action */ },
                                       bindingText: $profile.birth,
                                       placeholder: "test")
                        
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
                
                HStack(alignment: .center, spacing: 0) {
                    Text("지하철")
                        .font(.system(size: 14))
                        .frame(width: 52, alignment: .leading)
                    
                    FunchTextField(onSubmit: { /* action */ },
                                   bindingText: $profile.subwayName,
                                   placeholder: "지하철",
                                   leftImage: Image(systemName: "magnifyingglass"))
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
    
    
    @State var selectedJobs: Profile.Major?
    private var jobSelectionView: some View {
        HStack(spacing: 8) {
            ForEach(Profile.Major.dummies, id: \.self) { major in
                Button {
                    self.selectedJobs = major
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
