//
//  SubwayLines.swift
//  FunchApp
//
//  Created by 이성민 on 2/20/24.
//

import Foundation

enum SubwayLines: String, RawRepresentable, CaseIterable {
    case ONE
    case TWO
    case THREE
    case FOUR
    case FIVE
    case SIX
    case SEVEN
    case EIGHT
    case NINE
    case SEOHAE
    case AIRPORT
    case GIMPO
    case UI_SINSEOL
    case SILLIM
    case YOUNGIN
    case UIJEONGBU
    case BUNDANG
    case GYEONGCHUN
    case GYEONGUI
    case GYEONGGANG
    case INCHEON
    case INCHEON_TWO
    case SINBUNDANG
}

extension SubwayLines {
    static func contains(_ content: String) -> String? {
        switch content {
        case SubwayLines.ONE.rawValue: return "ONE"
        case SubwayLines.TWO.rawValue: return "TWO"
        case SubwayLines.THREE.rawValue: return "THREE"
        case SubwayLines.FOUR.rawValue: return "FOUR"
        case SubwayLines.FIVE.rawValue: return "FIVE"
        case SubwayLines.SIX.rawValue: return "SIX"
        case SubwayLines.SEVEN.rawValue: return "SEVEN"
        case SubwayLines.EIGHT.rawValue: return "EIGHT"
        case SubwayLines.NINE.rawValue: return "NINE"
        case SubwayLines.SEOHAE.rawValue: return "SEOHAE"
        case SubwayLines.AIRPORT.rawValue: return "AIRPORT"
        case SubwayLines.GIMPO.rawValue: return "GIMPO"
        case SubwayLines.UI_SINSEOL.rawValue: return "UI_SINSEOL"
        case SubwayLines.SILLIM.rawValue: return "SILLIM"
        case SubwayLines.YOUNGIN.rawValue: return "YOUNGIN"
        case SubwayLines.UIJEONGBU.rawValue: return "UIJEONGBU"
        case SubwayLines.BUNDANG.rawValue: return "BUNDANG"
        case SubwayLines.GYEONGCHUN.rawValue: return "GYEONGCHUN"
        case SubwayLines.GYEONGUI.rawValue: return "GYEONGUI"
        case SubwayLines.GYEONGGANG.rawValue: return "GYEONGGANG"
        case SubwayLines.INCHEON.rawValue: return "INCHEON"
        case SubwayLines.INCHEON_TWO.rawValue: return "INCHEON_TWO"
        case SubwayLines.SINBUNDANG.rawValue: return "SINBUNDANG"
        default: return nil
        }
    }
}
