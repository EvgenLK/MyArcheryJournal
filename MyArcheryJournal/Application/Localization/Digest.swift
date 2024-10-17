//
//  Digest.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 02.07.2024.
//

import Foundation

enum Tx {
    enum System {
        static let error = "System.error"
        static let close  = "System.close"
    }
    enum ListTraining {
        static let myTraining = "ScreenMain.Mytraining"
        static let training = "ScreenMain.training"
        static let statictics  = "ScreenMain.statistics"
        static let setting  = "ScreenMain.setting"
        static let emptyList  = "ScreenMain.emptyList"
    }
    enum AddTraining {
        static let addTraining = "AddTraining.addTraining"
        static let freeTraining = "AddTraining.free"
        static let fixedTraining = "AddTraining.fixed"
        static let markOnTarget = "AddTraining.markOnTarget"
        static let calculator = "AddTraining.calculator"
        static let inputMethod = "AddTraining.inputMethod"
        static let further = "AddTraining.further"
        static let notSelected = "AddTraining.notSelected"
    }
    enum DataInCell {
        static let milimetr = "DataInCell.milimetr"
        static let distance = "DataInCell.distance"
        static let average = "DataInCell.average"
    }
    enum CalculatorView {
        static let round = "CalculatorView.round"
        static let text_Ok = "CalculatorView.textOk"
        static let text_AttemptEnd = "CalculatorView.textAttemptEnd"
    }
}
