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
    var onChange: (String, String) -> Void
    /// onSubmit 동작
    var onSubmit: () -> Void
    /// 버튼 터치 액션
    var onTapButton: () -> Void = {}
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
    
    init(
        text: Binding<String>,
        placeholderText: String = "",
        backgroundColor: Color = .gray800,
        textLimit: Int? = nil,
        leadingImage: Image? = nil,
        trailingButtonImage: Image? = nil,
        isFocused: FocusState<Bool>? = nil,
        onChange: @escaping (String, String) -> Void = { _, _ in },
        onSubmit: @escaping () -> Void = {},
        onTapButton: @escaping () -> Void = {}
    ) {
        self.onChange = onChange
        self.onSubmit = onSubmit
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
            self.onTapButton = onTapButton
            self.trailingButtonImage = trailingButtonImage
            self.type = .button
        }
        else {
            self.type = .normal
        }
        
        if let isFocused {
            self._isFocused = isFocused
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
            leadingView
            
            textField
            
            trailingView
        }
        .padding(.leading, 16)
        .padding(.trailing, 8)
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
    private func onTextFieldChangeAction(_ value: String) {
        switch type {
        case .maxLength:
            guard let textLimit else { return }
            if value.count > textLimit {
                text = String(text.prefix(textLimit))
                isError = true
            }
            else if value.count < textLimit {
                isError = false
            }
        default:
            break
        }
    }
    
    /// textField UI
    private var textField: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholderText).foregroundColor(.gray400)
        )
        .focused($isFocused)
        .foregroundColor(.white)
        .font(.Funch.body)
        .onChange(of: text, perform: { value in
            onTextFieldChangeAction(value)
        })
        .onSubmit {
            onSubmit()
        }
    }
    
    /// textField의 leading 쪽에 오는 뷰
    @ViewBuilder
    private var leadingView: some View {
        switch type {
        case .icon:
            leadingImage?
                .resizable()
                .foregroundColor(.gray500)
                .frame(width: 24, height: 24)
                .padding(.trailing, 8)
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
                        .foregroundColor(textCountColor)
                    Text("/\(textLimit)")
                        .foregroundColor(textLimitColor)
                }
                .font(.Funch.body)
                .padding(.trailing, 8)
            }
            
        case .button:
            Button {
                onTapButton()
            } label: {
                trailingButtonImage?
                    .resizable()
                    .foregroundColor(.yellow500)
                    .frame(width: 24, height: 24)
                    .padding(8)
                    .background(.gray500)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
        default:
            EmptyView()
        }
    }
}
