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
            let results = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
            
            for object in results {
                context.delete(object)
            }
            
            try context.save()
        } catch {
            print("Ошибка при удалении объекта: \(error.localizedDescription)")
        }
    }
    
    func fetchAndPrintData() -> [TrainingModel] {
        let request: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(request)
            
            return results.compactMap { data in
                guard let trainingDataArray = data.trainingData as? [NSNumber] else {
                    return nil
                }
                
                let trainingArray = trainingDataArray.map { PointModel(point: $0.intValue) }
                return TrainingModel(
                    id: data.id,
                    typeTraining: Int(data.typeTraining),
                    imageTarget: data.image ?? "",
                    dateTraining: data.dateTraining ?? Date(),
                    nameTarget: data.nameTarget ?? "",
                    distance: Int(data.distance),
                    training: trainingArray
                )
            }
            
        } catch {
            print("Ошибка при получении данных из Core Data: \(error.localizedDescription)")
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
        let maxAttempts = model.seriesCount == 10 ? (10 * 3) * 2 : (6 * 6) * 2 // Константа для максимального количества попыток
        let attemptIndex = (model.numberSeries * model.attemptInSeries) - (model.attemptInSeries - (model.index + 1)) - 1 // Индекс для поиска попытки
        
        let context = managedObjectContext
        let fetchRequest: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", model.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            guard let training = results.first else {
                print("Тренировка с заданным ID не найдена.")
                return
            }
            
            var existingMarks = (training.trainingData as? [Int]) ?? []
            
            if model.changeInCell {
                // Обновляем существующую оценку
                existingMarks[attemptIndex] = model.mark
            } else {
                // Добавляем новую оценку
                existingMarks.append(model.mark)
            }
            
            // Проверяем количество оценок в зависимости от типа тренировки
            if (model.typetraining == 1 && existingMarks.count > maxAttempts) {
                print("Достигнут лимит попыток.")
                return
            }
            
            // Сохраняем данные
            training.trainingData = existingMarks as NSObject
            
            try context.save()
            print("Данные успешно сохранены.")
            
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
            
            guard let training = results.first else {
                print("Тренировка с заданным ID не найдена.")
                return
            }

            var existingMarks: [Int] = training.trainingData as? [Int] ?? []
            
            // Если массив меньшего размера, заполнить недостающие элементы
            while existingMarks.count <= numberAttempt {
                existingMarks.append(0)
            }

            existingMarks[numberAttempt] = 12 // Константа оценки для обновления
            training.trainingData = existingMarks as NSObject

            try context.save()
            print("Данные успешно обновлены.")
        } catch {
            print("Ошибка при получении данных: \(error.localizedDescription)")
        }
        
        updateAllTrainingData()
    }
}
