//
//  ProfileMBTIButtonPair.swift
//  FunchApp
//
//  Created by 이성민 on 1/22/24.
//

import SwiftUI

struct ProfileMBTIButtonPair: View {
    
    var action: (Int) -> Void
    var dataPair: [String]
    
    @State var buttonSelected: Int?
    
    init(onTap action: @escaping (Int) -> Void,
         dataPair: [String]) {
        self.action = action
        self.dataPair = dataPair
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<2) { i in
                    Button {
                        action(i)
                        self.buttonSelected = i
                    } label: {
                        Text(dataPair[i])
                            .foregroundStyle(buttonSelected == i ? Color.black : Color.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(buttonSelected == i ? Color.gray : Color.clear)
                    }
                    .buttonStyle(.noEffect)
                }
            }
        }
        .frame(width: 48, height: 96)
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
