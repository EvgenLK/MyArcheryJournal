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
        newTraining.nameTarget = data.nameTarget
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
    
    func deleteDataWithId(id: UUID) {
        let context = managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityTraining")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            // Выполняем запрос для получения объектов
            let results = try context.fetch(fetchRequest)
            
            // Удаляем каждый найденный объект
            for object in results {
                if let objectToDelete = object as? NSManagedObject {
                    context.delete(objectToDelete)
                }
            }
            // Сохраняем изменения
            try context.save()
        } catch {
            print("Ошибка при удалении объекта: \(error.localizedDescription)")
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
                    nameTarget: data.nameTarget ?? "",
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
    
    func saveOneTraining(with model: SaveOneTrainingModel) {
        let allAttempts = model.seriesCount == 10 ? (10 * 3) * 2 : (6 * 6) * 2 // этот код не будет никогда меняться это хардовая константа.
        let numberAttempt = (model.numberSeries * model.attemptInSeries) - (model.attemptInSeries - (model.index + 1)) - 1 //хардовая константа для поиска индекса
        let context = managedObjectContext
        let fetchRequest: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", model.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let training = results.first {
                var existingMarks: [Int]
                
                if let marks = training.trainingData as? [Int] {
                    existingMarks = marks
                } else {
                    existingMarks = []
                }
                
                if model.changeInCell {
                    existingMarks[numberAttempt] = model.mark

                } else {
                    existingMarks.append(model.mark)
                }
                // Проверяем количество оценок в зависимости от typetraining
                if model.typetraining == 1 {
                    if existingMarks.count <= allAttempts {
                        training.trainingData = existingMarks as NSObject
                        
                        // Сохраняем изменения в контексте
                        try context.save()
                        print("Данные успешно сохранены.")
                    } else {
                        print("Достигнут лимит попыток.")
                    }
                } else if model.typetraining == 0 {
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
                nameTarget: training.nameTarget ?? "",
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
    
    func deleteAttemptTraining(by id: UUID, _ attemptInSeries: Int, _ series: Int, _ index: Int) {
        let numberAttempt = (series * attemptInSeries) - (attemptInSeries - (index + 1)) - 1 // хардовая константа для поиска индекса
        let context = managedObjectContext
        let fetchRequest: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let training = results.first {
                var existingMarks: [Int] = []
                
                if let marks = training.trainingData as? [Int] {
                    existingMarks = marks
                } else if let marks = training.trainingData as? [NSNumber] {
                    // Если trainingData хранит NSNumber, преобразуем его в [Int]
                    existingMarks = marks.map { $0.intValue }
                }
                existingMarks[numberAttempt] = 12
                // Сохраняем обновленные оценки обратно в trainingData
                training.trainingData = existingMarks as NSObject
                
                try context.save()
                print("Данные успешно обновлены.")
            } else {
                print("Тренировка с заданным ID не найдена.")
            }
        } catch {
            print("Ошибка при получении данных: \(error.localizedDescription)")
        }
        updateAllTrainingData()
    }
}
