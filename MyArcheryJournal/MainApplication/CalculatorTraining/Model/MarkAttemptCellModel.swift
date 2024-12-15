//
//  MarkAttemptCellModel.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 18.08.2024.
//

import Foundation
import SwiftUI

struct RoundSection: Identifiable, Equatable {
    let id = UUID()
    let roundNumber: Int
    var roundSum: Int
    var trainings: [MarkAttemptCellModel]
    
    // Переопределение оператора == для Equatable
    static func == (lhs: RoundSection, rhs: RoundSection) -> Bool {
        return lhs.id == rhs.id &&
               lhs.roundNumber == rhs.roundNumber &&
               lhs.roundSum == rhs.roundSum &&
               lhs.trainings == rhs.trainings // Сравнение массивов также требует, чтобы MarkAttemptCellModel был Equatable
    }
}

struct MarkAttemptCellModel: Identifiable, Equatable {
    let id = UUID()
    let series: String
    var sumAllPoint: Int
    var numberAttempts: [String]

    // Переопределение оператора == для Equatable
    static func == (lhs: MarkAttemptCellModel, rhs: MarkAttemptCellModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.series == rhs.series &&
               lhs.sumAllPoint == rhs.sumAllPoint &&
               lhs.numberAttempts == rhs.numberAttempts // Сравнение массивов
    }
}
