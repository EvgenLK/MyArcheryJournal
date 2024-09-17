//
//  CalculatorController.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 25.08.2024.
//

import SwiftUI
import Combine

final class CalculatorController: ObservableObject {
    @Published var oneTrainingData: [MarkAttemptCellModel] = []
    
    let archeryServise: ArcheryService
    private var cancellables = Set<AnyCancellable>()
    
    init(archeryServise: ArcheryService) {
        self.archeryServise = archeryServise
        
        archeryServise.$trainingData
            .sink { [weak self] _ in
                self?.fetchOneTraining(UUID(), Int())
            }
            .store(in: &cancellables)
    }
    
    func fetchOneTraining(_ id: UUID, _ mark: Int) {
        oneTrainingData.removeAll()
        var sumPoints = 0
        var series = 1
        var pointArray = [String]()
        
        let oneTraining = archeryServise.fetchOneTraining(id)
        
        for point in oneTraining {
            sumPoints += point == 0 ? 10 : point // Считаем сумму очков
            pointArray.append(point == 0 ? "X" : "\(point)") // Добавляем в массив
            
            // Проверяем, достиг ли массив нужного размера
            if pointArray.count == 3 { // Здесь мы проверяем на 3
                oneTrainingData.append(MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray))
                sumPoints = 0
                pointArray.removeAll()
                series += 1
            }
            
            // Если у нас недостаточно точек для заполнения последней попытки
            if pointArray.count < 3 && point == oneTraining.last {
                // Это последний элемент в одном тренировочном наборе
                // Добавляем его в массив
                oneTrainingData.append(MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray))
            }
        }
    }
}
