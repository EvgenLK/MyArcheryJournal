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
    // MARK: - Property
    @Published var trainingData: [TrainingModel] = []
    
    private var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyArcheryData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension ArcheryService {
    
    func createOrUpdateTraining(_ data: TrainingModel) {
        let context = persistentContainer.viewContext
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
        var arrayTraining = [TrainingModel]()
        let request: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(request)
            
            for data in results {
                // Попробуем получить trainingData как массив
                guard let trainingDataArray = data.trainingData as? [NSNumber] else {
                    continue // Пропустить данный элемент, если он не корректный
                }
                
                // Преобразуем массив NSNumber в массив PointModel
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
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "EntityTraining")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Ошибка удаления всех данных: \(error.localizedDescription)")
        }
    }
    
    func saveOneTraining(by id: UUID, _ mark: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            
            // Проверяем, нашли ли мы тренировку по ID
            if let training = results.first {
                // Обновляем необходимые свойства. Пример:
                if var existingMarks = training.trainingData as? [Int] {
                    existingMarks.append(mark) // Добавляем новую отметку
                    training.trainingData = existingMarks as NSObject // Присваиваем обратно
                } else {
                    training.trainingData = [mark] as NSObject // Если ранее не было отметок, создаем новый массив
                }
                
                // Сохраняем изменения контекста
                try context.save()
                print("Данные успешно сохранены.")
            } else {
                print("Тренировка с заданным ID не найдена.")
            }
        } catch {
            print("Ошибка при сохранении данных: \(error.localizedDescription)")
        }
    }
    
    func fetchOneTraining(_ id: UUID) -> [Int] {
        var oneTraining = [Int]()
        let fetchRequest: NSFetchRequest<EntityTraining> = EntityTraining.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            
            for training in results {
                
                // Проверяем, что trainingData существует и преобразуем его
                if let points = training.trainingData as? [Int] {
                    oneTraining.append(contentsOf: points) // добавляем все значения в массив
                } else {
                    print("Нет тренировочных точек для данной тренировки.")
                }
            }
        } catch {
            print("Ошибка при получении данных: \(error.localizedDescription)")
        }
        
        return oneTraining
    }
    
    func updateAllTrainingData() {
        // Получаем новые данные из Core Data
        let newTrainingData = fetchAndPrintData()
        
        // Обновляем массив trainingData
        trainingData = newTrainingData
        
        print("Все данные успешно обновлены.")
    }
}
