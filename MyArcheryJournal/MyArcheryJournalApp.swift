//
//  MyArcheryJournalApp.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 01.07.2024.
//

import SwiftUI

@main
struct MyArcheryJournalApp: App {
    @StateObject private var archeryService = ArcheryService()
    @StateObject private var languageManager = LanguageManager()

    
    var body: some Scene {
        WindowGroup {
            ListTrainingView(archeryService: archeryService)
                .environmentObject(archeryService)
                .environmentObject(languageManager)
        }
    }
}
