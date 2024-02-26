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
            
        default: return .look
        }
    }
    
    static func findSubwayImageResource(from text: String) -> ImageResource {
        switch text.lowercased() {
        case SubwayLines.one.rawValue: return .subway1
        case SubwayLines.two.rawValue: return .subway2
        case SubwayLines.three.rawValue: return .subway3
        case SubwayLines.four.rawValue: return .subway4
        case SubwayLines.five.rawValue: return .subway5
        case SubwayLines.six.rawValue: return .subway6
        case SubwayLines.seven.rawValue: return .subway7
        case SubwayLines.eight.rawValue: return .subway8
        case SubwayLines.nine.rawValue: return .subway9
        case SubwayLines.seohae.rawValue: return .subwaySeohae
        case SubwayLines.airport.rawValue: return .subwayAirport
        case SubwayLines.gimpo.rawValue: return .subwayGimpoGoldline
        case SubwayLines.ui_sinseol.rawValue: return .subwayUiSinseol
        case SubwayLines.sillim.rawValue: return .subwaySillim
        case SubwayLines.youngin.rawValue: return .subwayYounginEver
        case SubwayLines.uijeongbu.rawValue: return .subwayUijeongbu
        case SubwayLines.bundang.rawValue: return .subwaySuinbundang
        case SubwayLines.gyeongchun.rawValue: return .subwayGyeongchun
        case SubwayLines.gyeongui.rawValue: return .subwayGyeonguiJungang
        case SubwayLines.gyeonggang.rawValue: return .subwayGeonggang
        case SubwayLines.incheon.rawValue: return .subwayIncheon1
        case SubwayLines.incheon_two.rawValue: return .subwayIncheon2
        case SubwayLines.sinbundang.rawValue: return .subwayShinbundang

        default: return .iconX
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
    
    static func findMBTIImageResource(from mbti: String) -> [ImageResource] {
        switch mbti {
        case MBTI.infp.rawValue: return [.infpDisabled, .infpActive]
        case MBTI.infj.rawValue: return [.infjDisabled, .infjActive]
        case MBTI.intp.rawValue: return [.intpDisabled, .intpActive]
        case MBTI.intj.rawValue: return [.intjDisabled, .intjActive]
        case MBTI.istp.rawValue: return [.istpDisabled, .istpActive]
        case MBTI.istj.rawValue: return [.istjDisabled, .istjActive]
        case MBTI.isfp.rawValue: return [.isfpDisabled, .isfpActive]
        case MBTI.isfj.rawValue: return [.isfjDisabled, .isfjActive]
        case MBTI.enfp.rawValue: return [.enfpDisabled, .enfpActive]
        case MBTI.enfj.rawValue: return [.enfjDisabled, .enfjActive]
        case MBTI.entp.rawValue: return [.entpDisabled, .entpActive]
        case MBTI.entj.rawValue: return [.entjDisabled, .entjActive]
        case MBTI.estp.rawValue: return [.estpDisabled, .estpActive]
        case MBTI.estj.rawValue: return [.estjDisabled, .estjActive]
        case MBTI.esfp.rawValue: return [.esfpDisabled, .esfpActive]
        case MBTI.esfj.rawValue: return [.esfjDisabled, .esfjActive]
            
        default: return []
        }
    }
}
