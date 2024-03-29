//
//  ResponseType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

protocol Respondable: Decodable {
    var status: String { get set }
    var message: String { get set }
}
