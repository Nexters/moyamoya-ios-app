//
//  ProfileEditorView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileEditorView: View {
    
    @State var userNickName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("프로필 만들기")
            Text("프로필을 바탕으로 매칭을 도와드려요")
            
            
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center) {
                    Text("닉네임")
                        .frame(width: 52, alignment: .leading)
                    
                    FunchTextField(onSubmit: {},
                                   bindingText: $userNickName,
                                   placeholder: "test",
                                   rightImage: Image(systemName: "magnifyingglass"))
                }
                
                HStack(alignment: .top) {
                    Text("직군")
                        .frame(width: 52, height: 48, alignment: .leading)
                    
                    HStack {
                        ChipView(title: "개발자", imageName: "plus")
                        Spacer()
                            .frame(width: 8)
                        ChipView(title: "디자이너", imageName: "plus")
                    }
                }
                
                HStack(alignment: .top) {
                    Text("동아리")
                        .frame(width: 52, height: 48, alignment: .leading)
                    
                    FlowLayoutGrid(alignment: .leading, itemSpacing: 8, lineSpacing: 8) {
                        ChipView(title: "넥스터즈", imageName: "plus")
                        ChipView(title: "SOPT", imageName: "plus")
                        ChipView(title: "Depromeet", imageName: "plus")
                    }
                }
                
                HStack(alignment: .top) {
                    Text("MBTI")
                }
                
                HStack(alignment: .top) {
                    Text("생일")
                        .frame(width: 52, height: 56, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        FunchTextField(onSubmit: {},
                                       bindingText: $userNickName,
                                       placeholder: "test")
                        Text("test")
                    }
                }
                
                HStack(alignment: .center) {
                    Text("지하철")
                        .frame(width: 52, alignment: .leading)
                    
                    FunchTextField(onSubmit: { print("🤔") },
                                   bindingText: $userNickName,
                                   placeholder: "지하철",
                                   leftImage: Image(systemName: "magnifyingglass"))
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(20)
        .background(Color.gray)
    }
    
    
}

#Preview {
    ProfileEditorView()
}



struct FlowLayoutGrid {
    var alignment: HorizontalAlignment = .leading
    var itemSpacing: CGFloat
    var lineSpacing: CGFloat
    
    init(alignment: HorizontalAlignment,
         itemSpacing: CGFloat,
         lineSpacing: CGFloat) {
        self.alignment = alignment
        self.itemSpacing = itemSpacing
        self.lineSpacing = lineSpacing
    }
}

extension FlowLayoutGrid: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return calculateLayout(of: sizes, containerWidth: width).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = calculateLayout(of: sizes, containerWidth: bounds.width).offsets
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: .init(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
        }
    }
}

extension FlowLayoutGrid {
    func calculateLayout(of subviewSizes: [CGSize], containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
        var offsets: [CGPoint] = []
        var containerSize: CGSize = .zero
        
        var curPos: CGPoint = .zero
        for size in subviewSizes {
            if curPos.x + size.width > containerWidth {
                curPos.x = 0
                curPos.y += size.height + lineSpacing
            }
            
            offsets.append(curPos)
            curPos.x += size.width + itemSpacing
            
            containerSize.width = max(containerSize.width, curPos.x)
            containerSize.height = max(containerSize.height, curPos.y + size.height)
        }
        
        return (offsets, containerSize)
    }
}
