//
//  FunchTextField.swift
//  FunchApp
//
//  Created by 이성민 on 1/20/24.
//

import SwiftUI

struct FunchTextField: View {
    
    @Binding var text: String
    let placeholderText: String
    let leadingImage: Image?
    let trailingImage: Image?
    
    init(text: Binding<String>,
         placeholderText: String = "",
         leadingImage: Image? = nil,
         trailingImage: Image? = nil) {
        self._text = text
        self.placeholderText = placeholderText
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: 8)
            
            leadingImage?
                .resizable()
                .padding(8)
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 8)
            
            TextField(placeholderText, text: $text)
                .font(.system(size: 14))
            
            Spacer()
                .frame(width: 8)
            
            trailingImage?
                .resizable()
                .padding(8)
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 8)
        }
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
