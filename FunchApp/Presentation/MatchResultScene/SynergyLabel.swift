//
//  SynergyLabel.swift
//  FunchApp
//
//  Created by 이성민 on 2/12/24.
//

import Foundation
import SwiftUI

struct SynergyLabel: View {
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(.iconInformation)
                .resizable()
                .frame(width: 24, height: 24)
            
            Spacer()
                .frame(width: 12)
            
            VStack(spacing: 0) {
                Text("fef")
                    .font(.Funch.subtitle1)
                    .foregroundStyle(.white)
                
                Spacer()
                    .frame(height: 2)
                
                Text("testt")
                    .font(.Funch.body)
                    .foregroundStyle(.gray400)
            }
            
            Spacer()
        }
    }
}

extension SynergyLabel {
    private func findImage(from text: String) -> Image {
        switch text {
        case "":
        }
    }
}
