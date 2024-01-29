//
//  SearchUserDTO.Request.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

extension RequestDTO {
    struct MatchingUser: Requestable {
        
        /// 내가 입력한 상대방 유저 코드
        var requestUserCode: String
        /// 내가 입력한 상대방 유저 코드
        var targetUserCode: String
        
        init(query: SearchUserQuery) {
            requestUserCode = query.requestUserCode
            targetUserCode = query.targetUserCode
        }
        
        var toDitionary: DictionaryType {
            [
                "requestMemberId": requestUserCode,
                "targetMemberCode": targetUserCode,
            ]
        }
    }
}

