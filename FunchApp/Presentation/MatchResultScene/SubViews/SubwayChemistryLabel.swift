//
//  SubwayChemistryLabel.swift
//  FunchApp
//
//  Created by 이성민 on 2/20/24.
//

import SwiftUI

struct SubwayChemistryLabel: View {
    
    private let targetName: String
    private let chemistryData: MatchingInfo.ChemistryInfo
    
    init(targetName: String, info chemistryData: MatchingInfo.ChemistryInfo) {
        self.targetName = targetName
        self.chemistryData = chemistryData
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(.findChemistryImageResource(from: chemistryData.title))
                .resizable()
                .frame(width: 24, height: 24)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(chemistryData.description + "에서 만나요")
                    .font(.Funch.subtitle1)
                    .foregroundStyle(.white)
                
                Spacer()
                    .frame(height: 2)
                
                Text(targetName + "님도" + chemistryData.description + "에 살고 있어요")
                    .font(.Funch.body)
                    .foregroundStyle(.gray400)
            }
            
            Spacer()
        }
    }
}
