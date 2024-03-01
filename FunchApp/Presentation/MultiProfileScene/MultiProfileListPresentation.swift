//
//  MultiProfileListPresentation.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/2/24.
//

import Foundation

enum MultiProfileListPresentation: Hashable, Identifiable {
    var id: Int { hashValue }
    
    case create
    case home
}
