//
//  CalculatorController.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 25.08.2024.
//

import SwiftUI
import Combine

final class CalculatorController: ObservableObject {
    @Published var oneTrainingData: [RoundSection] = []
    private let archeryServise: ArcheryService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(archeryServise: ArcheryService) {
        self.archeryServise = archeryServise
        
        archeryServise.$trainingData
            .sink { [weak self] _ in
                self?.fetchOneTraining(UUID(), Int())
            }
            .store(in: &cancellables)
    }
    
    func fetchOneTraining(_ id: UUID, _ attemptSeries: Int) {
        oneTrainingData.removeAll()
        
        // Получаем тренировку по идентификатору
        guard let training = archeryServise.fetchOneTraining(id) else {
            print("Тренировка не найдена.")
            return
        }
        
        let typeTraining = training.typeTraining
        
        if typeTraining != 1 {
            fetchfreeTraining(training, attemptSeries)
        } else {
            fetchfixedTraining(training, attemptSeries)
        }
    }
    
    func fetchfreeTraining(_ training: TrainingModel, _ attempt: Int) {
        var pointArray = [String]()
        var sumPoints = 0
        var series = 1
        let mark10 = 10
        let mark11 = 11
        
        oneTrainingData.append(RoundSection(roundNumber: 0, roundSum: 0, trainings: []))
        
        for (index, point) in training.training.enumerated() {
            let pointValue = point.point
            
            sumPoints += pointValue == mark11 ? mark10 : pointValue // Считаем сумму очков
            
            if pointValue == mark11 {
                pointArray.append("X")
            } else if pointValue == 0 {
                pointArray.append("M")
            } else {
                pointArray.append("\(pointValue)")
            }
            
            // Проверяем, достиг ли массив нужного размера
            if pointArray.count == attempt { // Здесь мы проверяем на значение mark
                let attemptMark = MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray)
                
                if var firstTraining = oneTrainingData.first {
                    firstTraining.trainings.append(attemptMark)
                    
                    // Обновляем первый элемент в массиве
                    oneTrainingData[0] = firstTraining
                }
                sumPoints = 0
                pointArray.removeAll()
                series += 1
            }
            
            // Если это последний элемент и у нас есть недостаточно точек для заполнения последней попытки
            if index == training.training.count - 1 && pointArray.count > 0 {
                let attemptMark = MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray)
                
                if var firstTraining = oneTrainingData.first {
                    firstTraining.trainings.append(attemptMark)
                    
                    // Обновляем первый элемент в массиве
                    oneTrainingData[0] = firstTraining
                }
            }
        }
    }
    
    func fetchfixedTraining(_ training: TrainingModel, _ attempt: Int) {
        var pointArray = [String]()
        var sumPoints = 0
        var series = 1
        var round = 1
        let numberRound = EnumCountSeriesInTarget.fromValueSeries(training.imageTarget).setCount
        var sumAllRound = 0
        
        for (index, point) in training.training.enumerated() {
            if oneTrainingData.count < round {
                oneTrainingData.append(RoundSection(roundNumber: round, roundSum: sumAllRound, trainings: []))
                sumAllRound = 0
            }
            
            let pointValue = point.point
            
            sumPoints += pointValue == 11 ? 10 : pointValue // Считаем сумму серии
            sumAllRound += pointValue == 11 ? 10 : pointValue // Считаем сумму раунда
            
            if pointValue == 11 {
                pointArray.append("X")
            } else if pointValue == 0 {
                pointArray.append("M")
            } else {
                pointArray.append("\(pointValue)")
            }
            
            // Проверяем, достиг ли массив нужного размера
            if pointArray.count == attempt { // Здесь мы проверяем на значение mark
                let attemptMark = MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray)
                
                if oneTrainingData.firstIndex(where: { $0.roundNumber == round }) != nil {
                    oneTrainingData[round - 1].trainings.append(attemptMark)
                    oneTrainingData[round - 1].roundSum += sumAllRound
                    round += oneTrainingData[round - 1].trainings.count == numberRound ? 1 : 0
                }
                sumAllRound = 0
                sumPoints = 0
                pointArray.removeAll()
                series += 1
            }
            
            // Если это последний элемент и у нас есть недостаточно точек для заполнения последней попытки
            if index == training.training.count - 1 && pointArray.count > 0 {
                let attemptMark = MarkAttemptCellModel(series: "\(series)", sumAllPoint: sumPoints, numberAttempts: pointArray)
                
                if oneTrainingData.firstIndex(where: { $0.roundNumber == round }) != nil {
                    oneTrainingData[round - 1].trainings.append(attemptMark)
                    oneTrainingData[round - 1].roundSum += sumAllRound
                }
            }
        }
    }
    
    func fetchBoolTrainingFull(_ trainingID: UUID, _ series: Int, _ typeTraining: Int) -> Bool {
        var markCount = 0
        let allAttempts = series == 10 ? (10 * 3) * 2 : (6 * 6) * 2 // этот код не будет никогда меняться это хардовая константа.
        
        if typeTraining == 1 {
            guard let training = archeryServise.fetchOneTraining(trainingID) else {
                print("Тренировка не найдена.")
                return false
            }
            
            for _ in training.training {
                markCount += 1
            }
            
            if markCount == allAttempts {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
