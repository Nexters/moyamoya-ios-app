//
//  ImageResource+.swift
//  FunchApp
//
//  Created by 이성민 on 2/16/24.
//

import Foundation
import SwiftUI

extension ImageResource {
    static func findProfileImageResource(from text: String) -> ImageResource {
        switch text.lowercased() {
        case "nexters": return .NEXTERS
        case "sopt": return .sopt
        case "depromeet": return .depromeet
        case "developer": return .developer
        case "designer": return .designer
        default: return .percent1
        }
    }
    
    static func findChemistryImageResource(from text: String) -> ImageResource {
        switch text {
        case "찾았다, 내 소울메이트!": return .mbti1
        case "기막힌 타이밍에 등장한 너!": return .mbti2
        case "끈끈한 사이로 발전할 수 있어요!": return .mbti3
        case "서로를 알아가 볼까요?": return .mbti4
        case "펀치가 아니면 몰랐을 사이": return .mbti5
            
        case "서로 다른 점을 찾는 재미": return .bloodBad
        case "안정적인 관계인 우리": return .bloodSoso
        case "우리는 최강의 콤비!": return .bloodGood
        case "쿵짝 쿵짜작~이 잘 맞아요": return .bloodGreat
            
        case SubwayLines.ONE.rawValue: return .subway1
        case SubwayLines.TWO.rawValue: return .subway2
        case SubwayLines.THREE.rawValue: return .subway3
        case SubwayLines.FOUR.rawValue: return .subway4
        case SubwayLines.FIVE.rawValue: return .subway5
        case SubwayLines.SIX.rawValue: return .subway6
        case SubwayLines.SEVEN.rawValue: return .subway7
        case SubwayLines.EIGHT.rawValue: return .subway8
        case SubwayLines.NINE.rawValue: return .subway9
        case SubwayLines.SEOHAE.rawValue: return .subwaySeohae
        case SubwayLines.AIRPORT.rawValue: return .subwayAirport
        case SubwayLines.GIMPO.rawValue: return .subwayGimpoGoldline
        case SubwayLines.UI_SINSEOL.rawValue: return .subwayUiSinseol
        case SubwayLines.SILLIM.rawValue: return .subwaySillim
        case SubwayLines.YOUNGIN.rawValue: return .subwayYounginEver
        case SubwayLines.UIJEONGBU.rawValue: return .subwayUijeongbu
        case SubwayLines.BUNDANG.rawValue: return .subwaySuinbundang
        case SubwayLines.GYEONGCHUN.rawValue: return .subwayGyeongchun
        case SubwayLines.GYEONGUI.rawValue: return .subwayGyeonguiJungang
        case SubwayLines.GYEONGGANG.rawValue: return .subwayGeonggang
        case SubwayLines.INCHEON.rawValue: return .subwayIncheon1
        case SubwayLines.INCHEON_TWO.rawValue: return .subwayIncheon2
        case SubwayLines.SINBUNDANG.rawValue: return .subwayShinbundang
            
        default: return .look
        }
    }
    
    static func findSynergyImageResource(from percentage: Int) -> ImageResource {
        switch percentage {
        case 0...20: return .percent5
        case 21...40: return .percent4
        case 41...60: return .percent3
        case 61...80: return .percent2
        case 81...100: return .percent1
        default: return .percent3
        }
    }
}
