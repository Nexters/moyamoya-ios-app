//
//  FunchTextField.swift
//  FunchApp
//
//  Created by 이성민 on 1/20/24.
//

import SwiftUI

struct FunchTextField: View {
    
    let action: () -> Void
    let bindingText: Binding<String>
    let placeholder: String
    
    let leftImage: Image?
    let rightImage: Image?
    
    init(onSubmit: @escaping () -> Void,
         bindingText: Binding<String>,
         placeholder: String = "",
         leftImage: Image? = nil,
         rightImage: Image? = nil
    ) {
        self.placeholder = placeholder
        self.bindingText = bindingText
        self.action = onSubmit
        self.leftImage = leftImage
        self.rightImage = rightImage
    }
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 8)
            
            leftImage?
                .resizable()
                .padding(8)
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 8)
            
            TextField(placeholder, text: bindingText)
                .font(.system(size: 14))
                .onSubmit {
                    action()
                }
            
            Spacer()
                .frame(width: 8)
            
            rightImage?
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
