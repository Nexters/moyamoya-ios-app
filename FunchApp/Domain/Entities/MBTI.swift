//
//  MBTI.swift
//  FunchApp
//
//  Created by 이성민 on 2/19/24.
//

import Foundation

enum MBTI: CaseIterable {
    case ei
    case ns
    case ft
    case pj
    
    var value: [String] {
        switch self {
        case .ei: return ["E", "I"]
        case .ns: return ["N", "S"]
        case .ft: return ["F", "T"]
        case .pj: return ["P", "J"]
        }
    }
    
    static var pairs: [[String]] {
        MBTI.allCases.map { $0.value }
    }
    
}
