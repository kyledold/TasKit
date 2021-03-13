//
//  TaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import CoreData
import Foundation

class TaskRowViewModel: TaskRowViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var isComplete: Bool
    
    var id: UUID { task.unwrappedId }
    var taskTitle: String { task.unwrappedTitle }
    
    private(set) var task: Task
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(task: Task, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        
        self.isComplete = task.status == .completed
    }
}
