//
//  MarkAttemptCellModel.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 18.08.2024.
//

import Foundation

struct RoundSection {
    let round: String
    let trainings: [MarkAttemptCellModel]
}

struct MarkAttemptCellModel: Identifiable {
    var id = UUID()
    let series: String
    let sumAllPoint: Int
    let numberAttempts: [String]
}

