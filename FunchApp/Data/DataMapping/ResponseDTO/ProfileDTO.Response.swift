//
//  ResponseDTO.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

extension ResponseDTO {
    struct ProfileDTO: ResponseType {
        var status: Int
        var message: String
    }
}

extension ResponseDTO.ProfileDTO {
    func toDomain() -> Profile {
        return Profile.testableValue
    }
}
