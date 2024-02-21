//
//  DeleteProfileQuery.swift
//  FunchApp
//
//  Created by 이성민 on 2/21/24.
//

import Foundation

struct DeleteProfileQuery {
    /// 삭제할 프로필 id
    var profileId: String
    
    init(profileId: String) {
        self.profileId = profileId
    }
}
