//
//  ViewBuildable.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/18/24.
//

import SwiftUI

protocol Buildable {
    associatedtype _Body
    typealias Body = _Body
    
    var container: DependencyType { get set }
    
    @ViewBuilder
    var body: Body { get }
}

//@resultBuilder
//enum ViewBuildableType {
//    static func buildBlock(_ components: any View...) -> some View {
//        EmptyView()
//    }
//}
