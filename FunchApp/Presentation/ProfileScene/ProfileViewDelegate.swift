//
//  ProfileViewDelegate.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/10/24.
//

protocol ProfileViewDelegate: AnyObject {
    /// 프로필 삭제시 호출
    func delete(profile: Profile)
}
