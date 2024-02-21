//
//  DeleteProfile.Req.swift
//  FunchApp
//
//  Created by 이성민 on 2/21/24.
//

import Foundation

extension RequestDTO {
    struct DeleteProfile: Requestable {
        
        var profileId: Int
        
        init(query: DeleteProfileQuery) {
            profileId = query.profileId
        }
        
        var path: String {
            "\(profileId)"
        }
    }
}
