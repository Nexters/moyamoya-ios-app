//
//  SearchSubwayStationDTO.Request.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

extension RequestDTO {
    struct SearchSubwayStationDTO: Requestable {
        
        var searchText: String
        
        init(query: SearchSubwayStationQuery) {
            searchText = query.searchText
        }
        
        var toDitionary: DictionaryType {
            [
                "searchText": searchText,
            ]
        }
    }
}

