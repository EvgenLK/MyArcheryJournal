//
//  SnackBarManager.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 29.11.2024.
//

import SwiftUI
import Combine

final class SnackBarManager: ObservableObject {
    @Published var showSnackBar: Bool = false
    @Published var snackBarMessage: String = ""
    
    func show(message: String) {
        snackBarMessage = message
        showSnackBar = true
    }
}
