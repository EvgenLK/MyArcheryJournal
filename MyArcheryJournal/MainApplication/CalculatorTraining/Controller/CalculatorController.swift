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
        
        for (index, point) in oneTraining.enumerated() {
            sumPoints += point == 11 ? 10 : point // Считаем сумму очков
            if point == 11 {
                pointArray.append("X")
            } else if point == 0 {
                pointArray.append("M")
            } else {
                pointArray.append("\(point)")
            }

            // Проверяем, достиг ли массив нужного размера
            if pointArray.count == mark { // Здесь мы проверяем на 3
                oneTrainingData.append(MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray))
                sumPoints = 0
                pointArray.removeAll()
                series += 1
            }
            // Если это последний элемент и у нас есть недостаточно точек для заполнения последней попытки
            if index == oneTraining.count - 1 && pointArray.count > 0 {
                oneTrainingData.append(MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray))
            }
        }
    }
}
