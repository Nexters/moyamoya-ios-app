//
//  ProfileMBTIButtonSet.swift
//  FunchApp
//
//  Created by 이성민 on 1/22/24.
//

import SwiftUI

//struct MBTI {
//    enum EI: String, RawRepresentable, CaseIterable, Hashable { case E, I }
//    enum NS: String, RawRepresentable, CaseIterable, Hashable { case N, S }
//    enum FT: String, RawRepresentable, CaseIterable, Hashable { case F, T }
//    enum PJ: String, RawRepresentable, CaseIterable, Hashable { case P, J }
//    
//    var first: EI
//    var second: NS
//    var third: FT
//    var fourth: PJ
//    
//    static let mbtiPairDummy: [[String]] = [["E", "I"], ["N", "S"], ["F", "T"], ["P", "J"]]
//    
//    func toString() -> String {
//        return first.rawValue + second.rawValue + third.rawValue + fourth.rawValue
//    }
//}

struct ProfileMBTIButtonSet: View {
    
    /// 바인딩 할 Profile의 `MBTI`
    @Binding var selectedMBTI: String
    
    // FIXME: mbti 데이터 관련한 것들은 굳이 Entity로 뺄 필요는 없겠져 ? 그래도 여기 말고 다른데에 빼두긴 해야할듯
    let mbtiPairDummy: [[String]] = [["E", "I"], ["N", "S"], ["F", "T"], ["P", "J"]]
    /// 선택된 `MBTI`를 관리하기 위한 배열
    @State private var mbtiSelection: [String] = .init(repeating: String(), count: 4)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<4) { pairIndex in
                profileButtonPair(pairIndex: pairIndex)
            }
        }
    }
    
    @ViewBuilder
    private func profileButtonPair(pairIndex: Int) -> some View {
        VStack(spacing: 0) {
            ForEach(0..<2) { selectionIndex in
                ChipButton(
                    action: {
                        mbtiSelection[pairIndex] = mbtiPairDummy[pairIndex][selectionIndex]
                        selectedMBTI = mbtiSelection.reduce("", { base, selection in
                            base + selection
                        })
                    },
                    title: mbtiPairDummy[pairIndex][selectionIndex],
                    isSelected: isSelected(mbtiPairDummy[pairIndex][selectionIndex])
                )
            }
        }
        .background(.gray800)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func isSelected(_ selected: String) -> Bool {
        return mbtiSelection.contains(selected)
    }
}
