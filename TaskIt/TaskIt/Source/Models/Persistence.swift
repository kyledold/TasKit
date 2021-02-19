//
//  Persistence.swift
//  NetworkKit
//
//  Created by Kyle Dold on 15/02/2021.
//

import CoreData

public struct PersistenceController {
    
    // MARK: - Properties
    
    public static let shared = PersistenceController()
    
    public let container: NSPersistentCloudKitContainer
    
    // MARK: - Initialisation

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: Constants.containerName)
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

// MARK: Constants

extension PersistenceController {
    private struct Constants {
        static let containerName = "TaskIt"
    }
}
