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

    }
}
