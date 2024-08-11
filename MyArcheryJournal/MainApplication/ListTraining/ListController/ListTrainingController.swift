//
//  ListTrainingController.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 28.07.2024.
//

import SwiftUI

final class ListTrainingController: ObservableObject {
    @Published var training: [TrainingSection] = []
    
    let archeryServise: ArcheryService
    
    init(archeryServise: ArcheryService) {
        self.archeryServise = archeryServise
    }
    
    func saveTraining(_ data: TrainingModel) {
        archeryServise.createOrUpdateTraining(data)
    }
    
    func fetchTraining() {
        training.removeAll()
        
        let trainingAllData = archeryServise.fetchAndPrintData()
        
        guard !trainingAllData.isEmpty else {
            print("Нет доступных тренировок")
            return
        }
        
        let groupedTrainings = Dictionary(grouping: trainingAllData) {
            $0.dateTraining.formatDate("MM.YY")
        }
        
        training = groupedTrainings.map { (key, value) in
            let trainingCells = value.map { data in
                ListTrainingModelCell(imageTaghet: data.imageTarget.fromStringInImage(),
                                  dateTraining: data.dateTraining.formatDate("dd.MM"),
                                  countShot: "100",
                                  allShot: "200",
                                  distance: "\(data.distance)",
                                  nameTaget: data.nameTaget,
                                  avarageShot: "9")
            }
            return TrainingSection(monthYear: key, trainings: trainingCells)
        }.sorted(by: { $0.monthYear > $1.monthYear })
    }
    
    func deleteAlldata() {
        archeryServise.deleteAll()
    }
}
