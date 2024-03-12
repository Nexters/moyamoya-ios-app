//
//  MultiProfileListDelegate.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/10/24.
//

import Foundation

protocol MultiProfileListDelegate: AnyObject {
    /// 프로필 변경
    func change(profile: Profile)
}
