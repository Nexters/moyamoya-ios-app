//
//  SubwayChipView.swift
//  FunchApp
//
//  Created by 이성민 on 2/20/24.
//

import SwiftUI

struct SubwayChipView: View {
    
    let subway: SubwayInfo
    
    init(subway: SubwayInfo) {
        self.subway = subway
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(subway.name)
                .font(.Funch.body)
                .foregroundStyle(.white)
            
            Spacer()
                .frame(width: 4)
            
            HStack(spacing: 2) {
                ForEach(subway.lines, id: \.self) { line in
                    Image(.findSubwayImageResource(from: line))
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 16)
        .background(.gray500)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

