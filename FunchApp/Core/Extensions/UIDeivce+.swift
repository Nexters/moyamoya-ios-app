//
//  UIDeivce+.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/22/24.
//

import UIKit

extension UIDevice {
    /// 해당 기기의 디바이스 아이디 값
    static var uuidString: String {
        UIDevice.current.identifierForVendor?.uuidString ?? "_e"
    }
    
    /// notch가 있는지 없는지 나타내는 Bool 값
    var hasNotch: Bool {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows
        
        let bottom = window?.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        
        return bottom > 0
    }
}
