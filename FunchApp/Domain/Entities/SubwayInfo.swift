//
//  SubwayInfo.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/27/24.
//

import Foundation

/// 지하철 역 정보
struct SubwayInfo: Hashable, Codable {
    /// 지하철 이름
    var name: String
    /// 호선 정보
    var lines: [String]
}

extension SubwayInfo {
    static var testableValue: SubwayInfo = .init(name: "고속터미널", lines: ["3", "7", "9"])
    static var empty: SubwayInfo = .init(name: "", lines: [])
}
