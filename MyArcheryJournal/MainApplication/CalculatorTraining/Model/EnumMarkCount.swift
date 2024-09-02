//
//  EnumMarkCount.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 29.08.2024.
//

enum EnumMarkCount: Int {
    case mark_3
    case mark_6
    case empty
    
    var markCount: Int {
        switch self {
        case .mark_3:
            return 3
        case .mark_6:
            return 6
        case .empty:
            return 0
        }
    }
    static func fromValue(_ value: Int) -> EnumMarkCount {
        switch value {
        case 12, 18:
            return .mark_3
        case 30, 50, 60, 70, 90:
            return .mark_6
        default:
            return .empty
        }
    }
}


