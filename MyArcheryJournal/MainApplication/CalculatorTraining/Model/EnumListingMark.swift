//
//  EnumListingMark.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 18.09.2024.
//

enum EnumListingMark {
    case mark_X
    case mark_10
    case mark_9
    case mark_8
    case mark_7
    case mark_6
    case mark_5
    case mark_4
    case mark_3
    case mark_2
    case mark_1
    case mark_M
    case mark_dash
    case empty
    
    var setMark: Int  {
        switch self {
        case .mark_X:
            return 11
        case .mark_10:
            return 10
        case .mark_9:
            return 9
        case .mark_8:
            return 8
        case .mark_7:
            return 7
        case .mark_6:
            return 6
        case .mark_5:
            return 5
        case .mark_4:
            return 4
        case .mark_3:
            return 3
        case .mark_2:
            return 2
        case .mark_1:
            return 1
        case .mark_M:
            return 0
        case .mark_dash:
            return 12
        case .empty:
            return 0
        }
    }
    
    var setMarkString: String  {
        switch self {
        case .mark_X:
            return "X"
        case .mark_10:
            return "10"
        case .mark_9:
            return "9"
        case .mark_8:
            return "8"
        case .mark_7:
            return "7"
        case .mark_6:
            return "6"
        case .mark_5:
            return "5"
        case .mark_4:
            return "4"
        case .mark_3:
            return "3"
        case .mark_2:
            return "2"
        case .mark_1:
            return "1"
        case .mark_M:
            return "М"
        case .mark_dash:
            return "12"
        case .empty:
            return "0"
        }
    }
    
    static func fromValue(_ value: String) -> EnumListingMark {
        switch value {
        case "X":
            return .mark_X
        case "10":
            return .mark_10
        case "9":
            return .mark_9
        case "8":
            return .mark_8
        case "7":
            return .mark_7
        case "6":
            return .mark_6
        case "5":
            return .mark_5
        case "4":
            return .mark_4
        case "3":
            return .mark_3
        case "2":
            return .mark_2
        case "1":
            return .mark_1
        case "M":
            return .mark_M
        case "-":
            return .mark_dash
        default:
            return .empty
        }
    }
    
    static func fromValueString(_ value: Int) -> EnumListingMark {
        switch value {
        case 11:
            return .mark_X
        case 10:
            return .mark_10
        case 9:
            return .mark_9
        case 8:
            return .mark_8
        case 7:
            return .mark_7
        case 6:
            return .mark_6
        case 5:
            return .mark_5
        case 4:
            return .mark_4
        case 3:
            return .mark_3
        case 2:
            return .mark_2
        case 1:
            return .mark_1
        case 0:
            return .mark_M
        case 12:
            return .mark_dash
        default:
            return .empty
        }
    }
}
