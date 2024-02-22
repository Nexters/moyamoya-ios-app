//
//  DeleteProfile.Res.swift
//  FunchApp
//
//  Created by 이성민 on 2/22/24.
//

import Foundation

extension ResponseDTO {
    struct DeleteProfile: Respondable {
        var status: String
        var message: String
        var data: String
    }
}

extension ResponseDTO.DeleteProfile {
    func toDomain() -> String {
        return data
    }
}
