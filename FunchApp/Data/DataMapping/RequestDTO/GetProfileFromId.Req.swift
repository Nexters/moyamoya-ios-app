//
//  GetProfileFromId.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/29/24.
//

import Foundation

extension RequestDTO {
    /// 아이디로 프로필을 조회
    struct GetProfileFromId: Requestable {
        var id: String
        
        init(id: String) {
            self.id = id
        }
        
        var toDitionary: DictionaryType {
            [
                "id": id,
            ]
        }
    }
}
