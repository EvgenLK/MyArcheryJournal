//
//  EnumDistance.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 29.07.2024.
//

import Foundation

enum EnumDistance: String, CaseIterable {
    case notSelected = "Не выбрано"
    case twelve = "12"
    case eighteen = "18"
    case thirty = "30"
    case fifty = "50"
    case sixty = "60"
    case seventy = "70"
    case ninety = "90"

    var localized: String {
        switch self {
        case .notSelected:
            return Tx.AddTraining.notSelected.localized()
        default:
            return self.rawValue
        }
    }
}
