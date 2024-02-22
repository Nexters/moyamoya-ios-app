//
//  FunchDropDownMenu.swift
//  FunchApp
//
//  Created by 이성민 on 2/8/24.
//

import SwiftUI

struct FunchDropDownMenu: View {
    
    /// 선택된 menu의 index
    @Binding var selectedData: String
    /// 내부에 들어갈 데이터
    var data: [String]
    
    init(selectedData: Binding<String>, data: [String]) {
        self._selectedData = selectedData
        self.data = data
    }
    
    /// Dropdown이 활성화 되어 있는지 나타내는 변수
    @State private var isShown: Bool = false
    
    
    var body: some View {
        Menu {
            ForEach(0..<data.count, id: \.self) { dataIndex in
                innerMenu(dataIndex: dataIndex)
            }
        } label: {
            outerMenu
        }
        .onTapGesture {
            isShown.toggle()
        }
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            if isShown {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white, lineWidth: 1)
            }
        }
    }
    
    // MARK: - UI components
    /// 외부에서 보이는 menu UI
    private var outerMenu: some View {
        HStack(spacing: 0) {
            Text(selectedData)
                .font(.Funch.body)
                .foregroundColor(.white)
            
            Spacer()
            
            // FIXME: 주어진 이미지로 변경
            Image(systemName: isShown ? "chevron.up" : "chevron.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 8)
                .foregroundColor(.gray400)
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .frame(maxWidth: .infinity)
    }
    
    /// tap 했을 때 보이는 menu들
    private func innerMenu(dataIndex: Int) -> some View {
        Button {
            isShown = false
            selectedData = data[dataIndex]
        } label: {
            Text(data[dataIndex])
        }
    }
}
