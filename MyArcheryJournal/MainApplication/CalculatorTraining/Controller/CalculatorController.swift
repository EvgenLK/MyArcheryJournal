//
//  CalculatorController.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 25.08.2024.
//

import SwiftUI
import Combine

final class CalculatorController: ObservableObject {
    @Published var oneTraining: [MarkAttemptCellModel] = []
    
    let archeryServise: ArcheryService
    private var cancellables = Set<AnyCancellable>()
    
    init(archeryServise: ArcheryService) {
        self.archeryServise = archeryServise
        
        archeryServise.$trainingData
            .sink { [weak self] _ in
                self?.fetchOneTraining(UUID())
            }
            .store(in: &cancellables)
    }
    
    func saveTraining(_ data: TrainingModel) {
        archeryServise.createOrUpdateTraining(data)
    }
    
    func fetchOneTraining(_ id: UUID) {
        oneTraining.removeAll() // Очищаем старые данные
        
        guard let trainingOneData = archeryServise.fetchAndPrintData().last else {
            // Если нет данных, просто выходим из функции
            return
        }
        //
        ////         Предположим, trainingOneData имеет свойства, которые нам нужны
        ////         Например, предполагаем, что trainingOneData имеет массив `attempts`
        //
        //                for attempt in trainingOneData.training { // Измените `attempts` на соответствующее свойство
        //                    let markAttempt = MarkAttemptCellModel(
        //                        series: attempt.series,                 // Извлечение строки для серии
        //                        sumAllPoint: "\(attempt.sumAllPoints)", // Преобразовываем сумму очков в строку
        //                        numberAttempts: attempt.numberAttempts   // Массив чисел попыток
        //                    )
        //
        //                    oneTraining.append(markAttempt) // Добавляем в массив oneTraining
        //                }
        //
        //                // После обновления oneTraining будет автоматически обновлено представление
        //            }
        //    }
    }
}
