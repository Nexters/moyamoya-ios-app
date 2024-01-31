//
//  FunchTextField.swift
//  FunchApp
//
//  Created by 이성민 on 1/20/24.
//

import SwiftUI

struct FunchTextField: View {
    
    @Binding var text: String
    /// placeholder
    let placeholderText: String
    /// 좌측에 넣을 이미지
    let leadingImage: Image?
    /// 글자수 제한 있는 Textfield 용 글자 제한 수
    let textLimit: Int?
    
    
    /// Textfield에 focus가 되어 있는지 판단하는 변수
    @FocusState private var isFocused: Bool
    /// Textfield에 error가 있는지 판단하는 변수
    @State private var isError: Bool = false
    
    
    /// border 색상
    private var borderColor: Color {
        if isError { return .coral500 }
        else if !isFocused { return .gray800 }
        else { return .white }
    }
    /// text의 개수를 세는 부분의 색상
    private var textCountColor: Color {
        if isError { return .coral500 }
        else if !text.isEmpty { return .white }
        else { return .gray400 }
    }
    /// text의 개수 제한 부분의 색상
    private var textLimitColor: Color {
        if isError { return .coral500 }
        else { return .gray400 }
    }
    
    
    init(text: Binding<String>,
         placeholderText: String = "",
         leadingImage: Image? = nil,
         textLimit: Int? = nil) {
        self._text = text
        self.placeholderText = placeholderText
        self.leadingImage = leadingImage
        self.textLimit = textLimit
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
            
            TextField(
                "",
                text: $text,
                prompt: Text(placeholderText).foregroundStyle(.gray400)
            )
            .focused($isFocused)
            .foregroundStyle(.white)
            .font(.Funch.body)
            .onChange(of: text) { _, _ in
                guard let textLimit else { return }
                if text.count > textLimit {
                    text = String(text.prefix(textLimit))
                    isError = true
                } else {
                    isError = false
                }
            }
            
            Spacer()
                .frame(width: 8)
            
            textLimitLabel
            
            Spacer()
                .frame(width: 8)
        }
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(borderColor, lineWidth: 1)
        }
    }
    
    @ViewBuilder
    private var textLimitLabel: some View {
        if let textLimit {
            HStack(spacing: 0) {
                Text("\(text.count)")
                    .foregroundStyle(textCountColor)
                Text("/\(textLimit)")
                    .foregroundStyle(textLimitColor)
            }
            .font(.Funch.body)
            .padding(8)
        }
    }
}
