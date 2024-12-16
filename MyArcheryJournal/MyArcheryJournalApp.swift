//
//  MyArcheryJournalApp.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 01.07.2024.
//

import SwiftUI

@main
struct MyArcheryJournalApp: App {
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled: Bool = false
    @StateObject private var archeryService = ArcheryService()
    @StateObject private var languageManager = LanguageManager()
    @StateObject private var snackBarManager = SnackBarManager()

    var body: some Scene {
        WindowGroup {
            ListTrainingView(archeryService: archeryService)
                .environmentObject(archeryService)
                .environmentObject(languageManager)
                .environmentObject(snackBarManager)
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
    }
}
