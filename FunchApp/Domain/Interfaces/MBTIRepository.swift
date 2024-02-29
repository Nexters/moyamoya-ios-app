//
//  MBTIRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 3/1/24.
//

import Foundation

protocol MBTIRepository {
    func count(mbti: String) -> Int
    func save(mbti: String)
}
