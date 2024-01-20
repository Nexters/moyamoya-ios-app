//
//  ProfileView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("USERCODE")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.48))
            
            Text("동대문역사문화공원역")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 0.68, green: 0.68, blue: 0.68))
                .frame(maxWidth: .infinity, alignment: .topLeading)
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
