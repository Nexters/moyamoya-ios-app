//
//  FetchUserQuery.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/3/24.
//

import UIKit

/// id를 기반으로 유저 조회
struct FetchUserQuery {
    
    /// 프로필 아이디
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var path: String {
        "\(id)"
    }
}
