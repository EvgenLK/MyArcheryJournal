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
    
    private let archeryServise: ArcheryService
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
                let totalShots = data.training.reduce(0) { ($0) + ($1.point == 11 ? 10 : $1.point) }
                let countOfShots = data.training.count * 10 + countPointShot(data.training.count, data.distance)
                let averageShots: Int
                if countOfShots > 0 {
                    averageShots = totalShots / data.training.count
                } else {
                    averageShots = 0
                }
                
                return ListTrainingModelCell(
                    imageTaghet: data.imageTarget.fromStringInImage(),
                    dateTraining: data.dateTraining.formatDate("dd.MM"),
                    countShot: "\(totalShots)" ,
                    allShot: "\(countOfShots)",
                    distance: "\(data.distance)",
                    nameTaget: data.nameTaget,
                    avarageShot: "\(averageShots)"
                )
            }
            
            return TrainingSection(monthYear: key, trainings: trainingCells)
        }.sorted(by: { $0.monthYear > $1.monthYear })
    }
    
    func deleteAlldata() {
        archeryServise.deleteAll()
    }
    
    func countPointShot(_ count: Int, _ distance: Int) -> Int {
        var countShot = 0
        
        let attemptTarget = distance == 12 || distance == 18 ?
        EnumMarkCount.fromValue(distance).markCount : EnumMarkCount.fromValue(distance).markCount
        
        if count % attemptTarget == 1 {
            countShot += 20
            
        } else if count % attemptTarget == 2 {
            countShot += 10
        }
        return countShot
    }
}
