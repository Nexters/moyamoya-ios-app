//
//  SynergyLabel.swift
//  FunchApp
//
//  Created by 이성민 on 2/12/24.
//

import Foundation
import SwiftUI

struct ChemistryLabel: View {
    
    private let chemistryData: MatchingInfo.ChemistryInfo
    
    init(info chemistryData: MatchingInfo.ChemistryInfo) {
        self.chemistryData = chemistryData
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(findImageResource(from: chemistryData.title))
                .resizable()
                .frame(width: 24, height: 24)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(chemistryData.title)
                    .font(.Funch.subtitle1)
                    .foregroundStyle(.white)
                
                Spacer()
                    .frame(height: 2)
                
                Text(chemistryData.description)
                    .font(.Funch.body)
                    .foregroundStyle(.gray400)
            }
            
            Spacer()
        }
    }
}

extension ChemistryLabel {
    private func findImageResource(from text: String) -> ImageResource {
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
}
