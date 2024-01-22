//
//  DynamicGrid.swift
//  FunchApp
//
//  Created by 이성민 on 1/21/24.
//

import SwiftUI

struct DynamicGrid {
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

extension DynamicGrid: Layout {
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

extension DynamicGrid {
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
