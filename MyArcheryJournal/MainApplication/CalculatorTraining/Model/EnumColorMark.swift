//
//  EnumColorMark.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 29.08.2024.
//

import SwiftUI

enum EnumColorMark {
    case yellow
    case red
    case blue
    case black
    case white

    var color: Color {
        switch self {
        case .yellow:
            return Color.yellow
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        case .black:
            return Color.black
        case .white:
            return Color.white
        }
    }
    
    static func fromValue(_ value: String) -> EnumColorMark {
        switch value {
        case "X","10","9":
            return .yellow
        case "8","7":
            return .red
        case "6","5":
            return .blue
        case "4", "3":
            return .black
        case "2","1","M":
            return .white
        default:
            return .white
        }
    }
    
    static func fromForegroundColor(_ value: String) -> EnumColorMark {
        switch value {
        case "X","10","9","2","1","M":
            return .black
        case "8","7","6","5","4", "3":
            return .white
        default:
            return .black
        }
    }
}
