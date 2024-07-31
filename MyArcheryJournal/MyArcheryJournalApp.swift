//
//  MyArcheryJournalApp.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 01.07.2024.
//

import SwiftUI

@main
struct MyArcheryJournalApp: App {
    @StateObject var trainingController = TrainingUserController()
    
    var body: some Scene {
        WindowGroup {
            ListTrainingView()
                .environmentObject(trainingController)
                .onAppear{
                    trainingController.featchTraining()
                }
        }
    }
}
