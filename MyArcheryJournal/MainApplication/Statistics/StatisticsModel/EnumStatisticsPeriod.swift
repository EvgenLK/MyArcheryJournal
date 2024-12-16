//
//  EnumStatisticsPeriod.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 10.12.2024.
//

enum EnumStatisticsPeriod: String, CaseIterable {
    case week, month, sixMonths
    
    var localized: String {
        switch self {
        case .week:
            return Tx.Periods.week.localized()
        case .month:
            return Tx.Periods.month.localized()
        case .sixMonths:
            return Tx.Periods.sixMonth.localized()
        }
    }
    
    var period: Int {
        switch self {
        case .week: return 1
        case .month: return 2
        case .sixMonths: return 3
        }
    }
}
