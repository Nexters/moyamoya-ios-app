//
//  DeleteProfileQuery.swift
//  FunchApp
//
//  Created by 이성민 on 2/21/24.
//

import Foundation

struct DeleteProfileQuery {
    /// 삭제할 프로필 id
    var profileId: Int
    
    init(profileId: Int) {
        self.profileId = profileId
    }
}
