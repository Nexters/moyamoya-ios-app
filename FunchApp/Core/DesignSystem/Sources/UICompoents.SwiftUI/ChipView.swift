//
//  ChipView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

/// 공통으로 사용되는 `ChipView`
struct ChipView: View {
    
    enum ViewType {
        /// 텍스트
        case text
        /// 이미지 + 텍스트
        case image
    }
    
    /// 칩 뷰 타입
    private(set) var type: ViewType
    
    init(title: String, imageName: String? = nil) {
        self.title = title
        
        if let imageName = imageName {
            self.type = .image
            self.imageName = imageName
        } else {
            self.type = .text
            self.imageName = ""
        }
    }
    
    /// 타이틀
    var title: String = ""
    /// 리소스 이름
    var imageName: String = ""
    
    var body: some View {
        switch type {
        case .text:
            HStack(alignment: .center, spacing: 0) {
                Text(title)
                    .font(.Funch.body)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(height: 48, alignment: .leading)
            .background(.gray500)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
        case .image:
            HStack(alignment: .center, spacing: 0) {
                Image(.findProfileImageResource(from: imageName))
                    .resizable()
                    .padding(7)
                    .frame(width: 32, height: 32)
                    .background(.gray900)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                    .frame(width: 8)
                
                Text(title)
                    .font(.Funch.body)
                    .foregroundColor(.white)
            }
            .padding([.vertical, .leading], 8)
            .padding(.trailing, 16)
            .frame(height: 48, alignment: .leading)
            .background(.gray500)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
