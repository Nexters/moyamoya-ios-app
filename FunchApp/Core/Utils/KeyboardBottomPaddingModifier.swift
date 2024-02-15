//
//  KeyboardBottomPaddingModifier.swift
//  FunchApp
//
//  Created by 이성민 on 2/15/24.
//

import Foundation
import SwiftUI

extension View {
    func keyboardBottomPadding(defaultHeight height: CGFloat) -> some View {
        modifier(KeyboardBottomPaddingModifier(defaultHeight: height))
    }
}

struct KeyboardBottomPaddingModifier: ViewModifier {
    
    private var defaultHeight: CGFloat
    
    init(defaultHeight: CGFloat = 0) {
        self.defaultHeight = defaultHeight
    }
    
    @State private(set) var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset + defaultHeight)
            .onAppear {
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillShowNotification,
                    object: nil,
                    queue: .main
                ) { notification in
                    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                    else { return }
                    offset = keyboardSize.height - defaultHeight
                }
                
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillHideNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    offset = 0
                }
            }
    }
}
