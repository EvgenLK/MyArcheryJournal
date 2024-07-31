//
//  TrainingUserController.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 28.07.2024.
//

import SwiftUI

final class TrainingUserController: ObservableObject {
    @Published var training: [TrainingCellModel] = []
    private var archeryServise = ArcheryService()
    
    func saveTraining(_ data: TrainingModel) {
        archeryServise.createOrUpdateTraining(data: data)
    }
    
    func featchTraining() {
        training.removeAll()
        let trainingAllData = archeryServise.fetchAndPrintData()
        trainingAllData.forEach { data in
            training.append(TrainingCellModel(imageTaghet: data.imageTarget.fromStringInImage(),
                                              dateTraining: data.dateTraining.formatDate("dd.MM"),
                                              countShot: "100",
                                              allShot: "200",
                                              distance: "\(data.distance)",
                                              nameTaget: data.nameTaget,
                                              avarageShot: "9"))
        }
    }
    
    func deleteAlldata() {
        archeryServise.deleteAll()
    }
}
