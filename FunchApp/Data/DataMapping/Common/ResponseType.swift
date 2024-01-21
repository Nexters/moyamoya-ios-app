//
//  ResponseType.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import Foundation

protocol ResponseType: Decodable {
    var status: Int { get set }
    var message: String { get set }
}
