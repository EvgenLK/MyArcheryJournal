//
//  EnumListingButton.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 30.08.2024.
//

import Foundation

enum EnumListingButton: String {
    case fullCountButton
    case shortCountButton
    case avrCountButton
    case empty
    
    var setButton: [String] {
        switch self {
        case .fullCountButton:
            return Array(arrayLiteral: "X","10","9","8","7","6","5","4","3","2","1","M")
        case .avrCountButton:
            return Array(arrayLiteral: "X","10","9","8","7","6","M")
        case .shortCountButton:
            return Array(arrayLiteral: "10","9","8","7","6","M")
        case .empty:
            return  Array(arrayLiteral: "-")
        }
    }
    static func fromValueTarget(_ value: String) -> EnumListingButton {
        switch value {
        case "universalFita3x20Ver":
            return .shortCountButton
        case "recurceFita3x20Ver", "compoundFita40mm5Circle":
            return .avrCountButton
        case "recurceFita40mm5Circle", "fita40mm", "fita122mm":
            return .fullCountButton
        default:
            return .empty
        }
    }
}
