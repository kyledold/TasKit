//
//  SubTask.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation
import CoreData

public class SubTask: NSManagedObject {
    
    // MARK: - Properties
    
    var unwrappedId: UUID { id ?? UUID() }
    var unwrappedTitle: String { title ?? "Unknown title"}
}
