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
            Image(.findChemistryImageResource(from: chemistryData.title))
                .resizable()
                .frame(width: 24, height: 24)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(chemistryData.title)
                    .font(.Funch.subtitle1)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 2)
                
                Text(chemistryData.description)
                    .font(.Funch.body)
                    .foregroundColor(.gray400)
            }
            
            Spacer()
        }
    }
}
