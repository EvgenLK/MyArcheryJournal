//
//  ListTrainingController.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 28.07.2024.
//

import SwiftUI
import Combine

final class ListTrainingController: ObservableObject {
    @Published var training: [TrainingSection] = []
    
    let archeryServise: ArcheryService
    private var cancellables = Set<AnyCancellable>()
    
    init(archeryServise: ArcheryService) {
        self.archeryServise = archeryServise
        
        archeryServise.$trainingData
            .sink { [weak self] _ in
                self?.fetchTraining()
            }
            .store(in: &cancellables)
    }
    
    func fetchTraining() {
        training.removeAll()
        
        let trainingAllData = archeryServise.fetchAndPrintData()
        
        guard !trainingAllData.isEmpty else {
            print("Нет доступных тренировок")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.YY"
        
        training = Dictionary(grouping: trainingAllData) { training in
            dateFormatter.string(from: training.dateTraining)
        }
        .map { (key, value) in
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
