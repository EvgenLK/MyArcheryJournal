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
        static let myTraining = "ListTraining.Mytraining"
        static let training = "ListTraining.training"
        static let statictics  = "ListTraining.statistics"
        static let setting  = "ListTraining.setting"
        static let emptyList  = "ListTraining.emptyList"
        static let deleteCell = "ListTraining.deleteCell"
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
        static let text_deleteAttempt = "CalculatorView.deleteAttempt"
        static let test_messageDelete = "CalculatorView.messageWantDelete"
        static let text_confirmationYes = "CalculatorView.confirmationYes"
        static let text_confirmationNo = "CalculatorView.confirmationNo"
    }
    enum SettingMain {
        static let themeBlack = "SettingMain.themeBlack"
        static let themeLight = "SettingMain.themeLight"
        static let selectLanguage = "SettingMain.selectLanguage"
        static let paidVersion = "SettingMain.paidVersion"
        static let userAgreement = "SettingMain.userAgreement"
        static let privacyPolicy = "SettingMain.privacyPolicy"
        static let copyrights = "SettingMain.copyrights"
        static let versionApp = "SettingMain.versionApp"
    }
    enum LanguageApp {
        static let english = "LanguageApp.English"
        static let russia = "LanguageApp.Russia"
    }
    enum UserEvents {
        static let createTraining = "UserEvents.trainingCreate"
        static let attemptDelete = "UserEvents.attemptDelete"
        static let trainingDelete = "UserEvents.trainingDelete"
        static let errorSave = "UserEvents.errorSave"
        static let errorDelete = "UserEvents.errorDelete"
    }
    enum StatisticsView {
        static let statisticsText = "StatisticsView.statistics_text"
        static let numberHits = "StatisticsView.numberHits_text"
        static let averageHits = "StatisticsView.averageHits_text"
    }
    enum Periods {
        static let week = "Periods.periodWeek"
        static let month = "Periods.periodMonth"
        static let sixMonth = "Periods.periodSixMonth"
    }
    enum SettingTraining {
        static let target = "SettingTraining.target"
    }
}
