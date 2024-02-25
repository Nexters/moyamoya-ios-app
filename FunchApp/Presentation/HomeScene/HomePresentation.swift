//
//  HomePresentation.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/22/24.
//

import Foundation

enum HomePresentation: Hashable, Identifiable {
    var id: Int { hashValue }
    
    case profile
    case matchResult(MatchingInfo)
    case mbtiCollection
    case easterEgg
}
