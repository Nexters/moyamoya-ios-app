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
}
