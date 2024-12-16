//
//  EnumCountSeriesInTarget.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 23.09.2024.
//

enum EnumCountSeriesInTarget {
    case teenSeries
    case sexSeries
    case empty
    
    var setCount: Int {
        switch self {
        case .sexSeries:
            return 6
        case .teenSeries:
            return 10
        case .empty:
            return  0
        }
    }
    
    static func fromValueSeries(_ value: String) -> EnumCountSeriesInTarget {
        switch value {
        case "universalFita3x20Ver", "recurceFita3x20Ver":
            return .teenSeries
        case "compoundFita40mm5Circle", "recurceFita40mm5Circle", "fita40mm", "fita122mm":
            return .sexSeries
        default:
            return .empty
        }
    }
}
