//
//  MBTI.swift
//  FunchApp
//
//  Created by Geon Woo lee on 2/23/24.
//

import Foundation

enum MBTI: String, CaseIterable {
    case infp
    case infj
    case intp
    case intj
    case istp
    case istj
    case isfp
    case isfj
    
    case enfp
    case enfj
    case entp
    case entj
    case estp
    case estj
    case esfp
    case esfj
}

extension MBTI {
    var imageResource: [ImageResource] {
        switch self {
        case MBTI.infp: return [.infpDisabled, .infpActive]
        case MBTI.infj: return [.infjDisabled, .infjActive]
        case MBTI.intp: return [.intpDisabled, .intpActive]
        case MBTI.intj: return [.intjDisabled, .intjActive]
        case MBTI.istp: return [.istpDisabled, .istpActive]
        case MBTI.istj: return [.istjDisabled, .istjActive]
        case MBTI.isfp: return [.isfpDisabled, .isfpActive]
        case MBTI.isfj: return [.isfjDisabled, .isfjActive]
        case MBTI.enfp: return [.enfpDisabled, .enfpActive]
        case MBTI.enfj: return [.enfjDisabled, .enfjActive]
        case MBTI.entp: return [.entpDisabled, .entpActive]
        case MBTI.entj: return [.entjDisabled, .entjActive]
        case MBTI.estp: return [.estpDisabled, .estpActive]
        case MBTI.estj: return [.estjDisabled, .estjActive]
        case MBTI.esfp: return [.esfpDisabled, .esfpActive]
        case MBTI.esfj: return [.esfjDisabled, .esfjActive]
        }
    }
}
