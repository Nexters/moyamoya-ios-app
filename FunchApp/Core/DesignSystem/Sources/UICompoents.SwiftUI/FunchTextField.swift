//
//  FunchTextField.swift
//  FunchApp
//
//  Created by 이성민 on 1/20/24.
//

import SwiftUI

struct FunchTextField: View {
    
    enum TextFieldType {
        /// 별다른 추가사항 없는 일반 텍스트필드
        case normal
        /// 최대 글자 수 제한이 있는 텍스트필드
        case maxLength
        /// 좌측에 아이콘이 들어간 텍스트필드
        case icon
        /// 우측에 버튼이 들어간 텍스트필드
        case button
    }
    
    /// 텍스트필드 타입
    private(set) var type: TextFieldType
    
    // MARK: - inputs
    /// TextField의 onChange에 들어갈 action
    var onChangeAction: (String, String) -> Void = { _, _ in }
    /// Binding
    @Binding var text: String
    /// placeholder
    let placeholderText: String
    /// 백그라운드 색상
    let backgroundColor: Color
    /// 좌측에 넣을 이미지
    var leadingImage: Image?
    /// 글자수 제한 있는 Textfield 용 글자 제한 수
    var textLimit: Int?
    /// 우측 버튼에 넣을 이미지
    var trailingButtonImage: Image?
    /// 버튼 터치 액션
    var buttonAction: () -> Void = {}
    
    init(
        onChangeAction: @escaping (String, String) -> Void = { _, _ in },
        text: Binding<String>,
        placeholderText: String = "",
        backgroundColor: Color = .gray800,
        textLimit: Int? = nil,
        leadingImage: Image? = nil,
        buttonAction: @escaping () -> Void = {},
        trailingButtonImage: Image? = nil
    ) {
        self.onChangeAction = onChangeAction
        self._text = text
        self.placeholderText = placeholderText
        self.backgroundColor = backgroundColor
        
        if let textLimit {
            self.textLimit = textLimit
            self.type = .maxLength
        }
        else if let leadingImage {
            self.leadingImage = leadingImage
            self.type = .icon
        }
        else if let trailingButtonImage {
            self.buttonAction = buttonAction
            self.trailingButtonImage = trailingButtonImage
            self.type = .button
        }
        else {
            self.type = .normal
        }
    }
    
    // MARK: - properties for UI
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
    
    // MARK: - body
    var body: some View {
        // 어쩔 수 없는 spacing -> 간격 조절을 위해 ...
        HStack(spacing: 8) {
            Spacer()
                .frame(width: 8)
            
            leadingView
            
            textField
            
            trailingView
            
            Spacer()
                .frame(width: 8)
        }
        .frame(height: 56)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(borderColor, lineWidth: 1)
        }
    }
    
    // MARK: - additional
    /// textField가 변화할 떄 실행될 action
    ///
    /// textField에 변화가 있을 때 필요한 action들이 다를 것이기 때문에,
    /// 글자 수 제한이 필요한 경우는 직접 구현해두었고,
    /// 그 외에는 직접 필요한 action을 구현하면 됩니다.
    private func onTextFieldChangeAction(_ oldValue: String, _ newValue: String) {
        switch type {
        case .maxLength:
            guard let textLimit else { return }
            if newValue.count > textLimit {
                text = oldValue
                isError = true
            }
            else if newValue.count < textLimit {
                isError = false
            }
        default:
            onChangeAction(oldValue, newValue)
        }
    }
    
    /// textField UI
    private var textField: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholderText).foregroundStyle(.gray400)
        )
        .focused($isFocused)
        .foregroundStyle(.white)
        .font(.Funch.body)
        .onChange(of: text) { oldText, newText in
            onTextFieldChangeAction(oldText, newText)
        }
    }
    
    /// textField의 leading 쪽에 오는 뷰
    @ViewBuilder
    private var leadingView: some View {
        switch type {
        case .icon:
            leadingImage?
                .resizable()
                .foregroundStyle(.gray500)
                .frame(width: 24, height: 24)
        default:
            EmptyView()
        }
    }
    
    /// textfield의 trailing 쪽에 오는 뷰
    @ViewBuilder
    private var trailingView: some View {
        switch type {
        case .maxLength:
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
            
        case .button:
            Button {
                buttonAction()
            } label: {
                trailingButtonImage?
                    .resizable()
                    .foregroundStyle(.yellow500)
                    .frame(width: 24, height: 24)
                    .padding(8)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
        default:
            EmptyView()
        }
    }
}
