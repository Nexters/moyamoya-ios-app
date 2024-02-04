//
//  SubwayInfo.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/27/24.
//

import Foundation

/// 지하철 역 정보
struct SubwayInfo: Hashable {
    /// 지하철 이름
    var name: String
    /// 호선 정보
    var lines: [String]
}
