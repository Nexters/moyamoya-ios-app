//
//  ProfileView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileView: View {
    let items: [String] = ["1", "2", "3"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("USERCODE")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
            
            Text("동대문역사문화공원역")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 0.68, green: 0.68, blue: 0.68))
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            HStack(spacing: 0) {
                Text("직군")
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                    .frame(width: 52, alignment: .leading)
                
//                Spacer()
//                    .frame(width: 14)
                
                ChipView(title: "Nexters", imageName: "")
                
                Spacer()
            }
//            .padding(.horizontal, 20)
            
            Grid(alignment: .leading) {
                GridRow {
                    Text("직군")
                        .frame(width: 52, alignment: .leading)
//                        .lineLimit(0)
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                        .background(.red)
                        
                    ChipView(title: "Nexters", imageName: "")
                    
//                    Spacer()
                }
            }
            
//            ChipView(title: "Nexters")
//            ChipView(title: "Nexters", imageName: "")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .frame(width: 320, alignment: .center)
        .background(.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.5)
                .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 1)
        )
    }
}

#Preview {
    ProfileView()
}
