//
//  EnumSnackBarMessage.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 03.12.2024.
//

import SwiftUI

enum EnumSnackBarMessage {
    case success
    case info
    case error
    
    var icon: Image {
        switch self {
        case .success:
            return ListImages.IconSnackBar.markSuccess
        case .info:
            return ListImages.IconSnackBar.markInformation
        case .error:
            return ListImages.IconSnackBar.markXFail
        }
    }
    
    var color: Color {
        switch self {
        case .success:
            return PaletteApp.adaptiveBGSuccessIcon
        case .info:
            return PaletteApp.systemGrey2Dark
        case .error:
            return PaletteApp.targetRed
        }
    }
    
    static func messageType(for text: String) -> EnumSnackBarMessage {
        switch text {
        case Tx.UserEvents.createTraining.localized():
            return .success
        case Tx.UserEvents.attemptDelete.localized(), Tx.UserEvents.trainingDelete.localized():
            return .info
        case Tx.UserEvents.errorDelete.localized(), Tx.UserEvents.errorSave.localized():
            return .error
        default:
            return .info
        }
    }
}
