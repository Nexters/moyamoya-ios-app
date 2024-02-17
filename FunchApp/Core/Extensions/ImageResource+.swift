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
