//
//  ArcheryService.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 09.07.2024.
//

import SwiftUI
import CoreData
import Combine

final class ArcheryService: ObservableObject {
    // MARK: - Свойства
    @Published var trainingData: [TrainingModel] = []
    
    private var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyArcheryData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Неустранимая ошибка \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension ArcheryService {
    
    func createTraining(_ data: TrainingModel) {
        let context = managedObjectContext
        let newTraining = EntityTraining(context: context)
        
        newTraining.id = data.id
        newTraining.image = data.imageTarget
        newTraining.dateTraining = data.dateTraining
        newTraining.nameTarget = data.nameTaget 
        newTraining.distance = Int64(data.distance)
        newTraining.typeTraining = Int32(data.typeTraining)
        newTraining.trainingData = data.training as NSObject
        
        do {
            try context.save()
            trainingData.append(data)
        } catch {
            print("Ошибка сохранения данных: \(error.localizedDescription)")
        }
    }
    
    func fetchAndPrintData() -> [TrainingModel] {
        let request: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        var arrayTraining = [TrainingModel]()
        
        do {
            let results = try managedObjectContext.fetch(request)
            
            for data in results {
                guard let trainingDataArray = data.trainingData as? [NSNumber] else {
                    continue
                }
                let trainingArray = trainingDataArray.map { PointModel(point: $0.intValue) }
                let model = TrainingModel(
                    id: data.id,
                    typeTraining: Int(data.typeTraining),
                    imageTarget: data.image ?? "",
                    dateTraining: data.dateTraining ?? Date(),
                    nameTaget: data.nameTarget ?? "",
                    distance: Int(data.distance),
                    training: trainingArray
                )
                arrayTraining.append(model)
            }
            return arrayTraining
            
        } catch {
            print("Ошибка при получении данных из Core Data: \(error)")
        }
        return []
    }
    
    func deleteAll() {
        let context = managedObjectContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "EntityTraining")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Ошибка удаления всех данных: \(error.localizedDescription)")
        }
    }
    
    func saveOneTraining(by id: UUID, _ mark: Int, _ series: Int, _ typetraining: Int) {
        let allAttempts = series == 10 ? (10 * 3) * 2 : (6 * 6) * 2
        let context = managedObjectContext
        let fetchRequest: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let training = results.first {
                var existingMarks: [Int]
                
                // Получить текущие оценки
                if let marks = training.trainingData as? [Int] {
                    existingMarks = marks
                } else {
                    existingMarks = []
                }
                
                // Добавляем новую оценку
                existingMarks.append(mark)
                
                // Проверяем количество оценок в зависимости от typetraining
                if typetraining == 1 {
                    if existingMarks.count <= allAttempts {
                        training.trainingData = existingMarks as NSObject
                        
                        // Сохраняем изменения в контексте
                        try context.save()
                        print("Данные успешно сохранены.")
                    } else {
                        print("Достигнут лимит попыток.")
                    }
                } else if typetraining == 0 {
                    // Если typetraining == 0, сохраняем без ограничения по количеству оценок
                    training.trainingData = existingMarks as NSObject
                    
                    // Сохраняем изменения в контексте
                    try context.save()
                    print("Данные успешно сохранены.")
                } else {
                    print("Некорректный тип тренировки.")
                }
            } else {
                print("Тренировка с заданным ID не найдена.")
            }
        } catch {
            print("Ошибка при сохранении данных: \(error.localizedDescription)")
        }
    }

    
    func fetchOneTraining(_ id: UUID) -> TrainingModel? {
        let fetchRequest: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            guard let training = results.first else {
                print("Тренировка не найдена.")
                return nil
            }

            // Извлечение данных из Core Data
            let trainingModel = TrainingModel(
                id: training.id,
                typeTraining: Int(training.typeTraining),
                imageTarget: training.image ?? "",
                dateTraining: training.dateTraining ?? Date(),
                nameTaget: training.nameTarget ?? "",
                distance: Int(training.distance),
                training: extractPoints(from: training.trainingData)
            )

            return trainingModel
            
        } catch {
            print("Ошибка при получении данных: \(error.localizedDescription)")
        }
        return nil
    }

    private func extractPoints(from data: NSObject?) -> [PointModel] {
        guard let pointsArray = data as? [Int] else {
            print("Неверный формат данных тренировки.")
            return []
        }
        return pointsArray.map { PointModel(point: $0) }
    }
    
    func updateAllTrainingData() {
        trainingData = fetchAndPrintData()
    }
}
