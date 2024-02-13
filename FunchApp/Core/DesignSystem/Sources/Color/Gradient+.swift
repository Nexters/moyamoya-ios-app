//
//  Color+.swift
//  FunchApp
//
//  Created by 이성민 on 2/8/24.
//

import Foundation
import SwiftUI

/// Funch 앱에서 사용하는 Gradient 모음
///
/// 사용하기 위해서는 `Gradient.funchGradient(type:)` 메소드 사용
enum FunchGradient {
    case lemon500
    case lemon600
    case lemon900
    case gray300
    case gray900
    
    /// 들어가는 색상들
    var stops: [Gradient.Stop] {
        switch self {
        case .lemon500:
            return [.init(color: .gradientLemon5001, location: 0.00),
                    .init(color: .gradientLemon5002, location: 1.00)]
        case .lemon600:
            return [.init(color: .gradientLemon6001, location: 0.00),
                    .init(color: .gradientLemon6001, location: 1.00)]
        case .lemon900:
            return [.init(color: .gradientLemon9001, location: 0.00),
                    .init(color: .gradientLemon9002, location: 1.00)]
        case .gray300:
            return [.init(color: .gradientGray3001, location: 0.00),
                    .init(color: .gradientGray3002, location: 1.00)]
        case .gray900:
            return [.init(color: .gradientGray9001, location: 0.00),
                    .init(color: .gradientGray9002, location: 1.00)]
        }
    }
    
    /// 시작 지점
    var startPoint: UnitPoint {
        switch self {
        case .lemon500: return .init(x: 0, y: 0.5)
        case .lemon600: return .init(x: 0, y: 0.5)
        case .lemon900: return .init(x: 0.5, y: 0)
        case .gray300: return .init(x: 0.5, y: 0.97)
        case .gray900: return .init(x: 0.5, y: 0)
        }
    }
    
    /// 끝나는 지점
    var endPoint: UnitPoint {
        switch self {
        case .lemon500: return .init(x: 1, y: 0.5)
        case .lemon600: return .init(x: 1, y: 0.5)
        case .lemon900: return .init(x: 0.5, y: 0.86)
        case .gray300: return .init(x: 0.5, y: 1)
        case .gray900: return .init(x: 0.5, y: 0.06)
        }
    }
}

extension Gradient {
    /// funch gradient를 return 하는 함수
    ///
    /// 새로운 gradient를 만들기 위해서는 `FunchGradient` 에 값들 추가 필요
    static func funchGradient(type: FunchGradient) -> LinearGradient {
        .init(stops: type.stops,
              startPoint: type.startPoint,
              endPoint: type.endPoint)
    }
}
