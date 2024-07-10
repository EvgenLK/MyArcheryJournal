//
//  ArcheryService.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 09.07.2024.
//

import SwiftUI
import CoreData


final class ArcheryService {
    // MARK: - Property
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
