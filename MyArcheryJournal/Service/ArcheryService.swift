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
        newTraining.id = UUID()
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
                let trainingSeriesArray = convertNSSetToArray(nsSet: data.trainingSeries)
                arrayTraining.append(TrainingModel(id: data.id,
                                                   typeTraining: Int(data.typeTraining) ,
                                                   imageTarget: data.image ?? "",
                                                   dateTraining: data.dateTraining ?? Date(),
                                                   nameTaget: data.nameTarget ?? "",
                                                   distance: Int(data.distance),
                                                   training: trainingSeriesArray))
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
    
    
//    func feathTrainingId(by id: UUID) -> TrainingModel? {
//        let fetchRequest = NSFetchRequest<EntityTraining>(entityName: "EntityTraining")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//        print(id)
//        do {
//            let results = try managedObjectContext.fetch(fetchRequest)
//            print(results)
//            return results.first.map { TrainingModel(id: $0.id,
//                                                     typeTraining: Int($0.typeTraining),
//                                                     imageTarget: $0.image ?? "",
//                                                     dateTraining: $0.dateTraining ?? Date(),
//                                                     nameTaget: $0.nameTarget ?? "",
//                                                     distance: Int($0.distance),
//                                                     training: convertNSSetToArray(nsSet: $0.trainingSeries))
//            }
//        } catch {
//            print("Ошибка при получении данных: \(error)")
//            return nil
//        }
//    }
    
//    func saveOneTraining
    
}
extension ArcheryService {
    
    func convertNSSetToArray(nsSet: NSSet?) -> [TrainingSeriesModel]? {
        guard let nsSet = nsSet else { return nil }
        return nsSet.allObjects.compactMap { $0 as? TrainingSeriesModel }
    }
}
