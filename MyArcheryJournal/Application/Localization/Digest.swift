//
//  Digest.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 02.07.2024.
//

import Foundation

enum Tx {
    enum System {
        static let error = NSLocalizedString("System.error", comment: "Ошибка")
        static let close  = NSLocalizedString("System.close", comment: "Закрыть")
    }
    enum ListTraining {
        static let myTraining = NSLocalizedString("ScreenMain.Mytraining", comment: "Мои тренировки")
        static let training = NSLocalizedString("ScreenMain.training", comment: "Тренировки")
        static let statictics  = NSLocalizedString("ScreenMain.statistics", comment: "Статистика")
        static let setting  = NSLocalizedString("ScreenMain.setting", comment: "Настройки")
        static let emptyList  = NSLocalizedString("ScreenMain.emptyList", comment: "Список тренировок пуст")
    }
    enum AddTraining {
        static let addTraining = NSLocalizedString("AddTraining.addTraining", comment: "Добавить тренировку")
        static let freeTraining = NSLocalizedString("AddTraining.free", comment: "Свободная")
        static let fixedTraining = NSLocalizedString("AddTraining.fixed", comment: "Фиксированая")
        static let markOnTarget = NSLocalizedString("AddTraining.markOnTarget", comment: "Отметка на мишени")
        static let calculator = NSLocalizedString("AddTraining.calculator", comment: "Калькулятор")
        static let inputMethod = NSLocalizedString("AddTraining.inputMethod", comment: "Способ ввода")
        static let further = NSLocalizedString("AddTraining.further", comment: "Далее")
        static let notSelected = NSLocalizedString("AddTraining.notSelected", comment: "Не выбрано")
    }
    enum DataInCell {
        static let milimetr = NSLocalizedString("DataInCell.milimetr", comment: "мм")
        static let distance = NSLocalizedString("DataInCell.distance", comment: "Дистанция")
        static let average = NSLocalizedString("DataInCell.average", comment: "Сред.")
    }
    enum CalculatorView {
        static let round = NSLocalizedString("CalculatorView.round", comment: "Раунд")
        static let text_Ok = NSLocalizedString("CalculatorView.textOk", comment: "OK")
        static let text_AttemptEnd = NSLocalizedString("CalculatorView.textAttemptEnd", comment: "Попытки закончены!")
    }
}
