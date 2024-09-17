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
        let container = NSPersistentContainer(name: "MyArheryJournal")
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
        newTraining.typeTraining = Int64(data.typeTraining)
        
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
                
                
                let trainingPointsArray = (data.trainingPoints as? Set<PointModel>)?.map { $0 } ?? []
                arrayTraining.append(TrainingModel(id: data.id,
                                                   typeTraining: Int(data.typeTraining) ,
                                                   imageTarget: data.image ?? "",
                                                   dateTraining: data.dateTraining ?? Date(),
                                                   nameTaget: data.nameTarget ?? "",
                                                   distance: Int(data.distance),
                                                   training: trainingPointsArray))
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
            let point1 = TrainingPoint(context: context)
            point1.point = Int64(mark)
            
            if let series = results.first {
                point1.points = series
                if let trainingPointsSet = series.trainingPoints as? NSMutableSet {
                    trainingPointsSet.add(point1)
                } else {
                    series.trainingPoints = NSMutableSet(object: point1)
                }
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
                print("distance: \(String(describing: training.distance))") // Здесь вы получаете фактическое значение
                if let points = training.trainingPoints as? Set<TrainingPoint>, !points.isEmpty {
                    for point in points {
                        print("Point: \(point.point) ") // Здесь вы получаете фактическое значение
                        oneTraining.append(Int(point.point))
                    }
                } else {
                    print("Нет тренировочных точек для данной тренировки.")
                }
            }
        } catch {
            
        }
        return oneTraining
    }
}

extension ArcheryService {
    
    func convertNSSetToArray(nsSet: NSSet?) -> [TrainingPoint]? {
        guard let nsSet = nsSet else { return nil }
        return nsSet.allObjects.compactMap { $0 as? TrainingPoint }
    }
}
