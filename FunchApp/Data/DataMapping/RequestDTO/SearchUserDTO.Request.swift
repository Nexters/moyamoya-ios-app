//
//  SearchUserDTO.Request.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

extension RequestDTO {
    struct SearchUserDTO: RequestType {
        
        var userCode: String
        
        init(query: SearchUserQuery) {
            userCode = query.userCode
        }
        
        var toDitionary: DictionaryType {
            [
                "userCode": userCode,
            ]
        }
    }
}

