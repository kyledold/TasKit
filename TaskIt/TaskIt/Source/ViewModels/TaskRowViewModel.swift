//
//  TaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import CoreData
import Foundation

class TaskRowViewModel: TaskRowViewModelProtocol {
    
    var id: UUID { return task.id ?? UUID() }
    var titleText: String
    var priority: Priority
    
    @Published var isCompleted: Bool
    
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task
    
    init(task: Task, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        
        self.titleText = task.title ?? .empty
        self.priority = task.priority
        self.isCompleted = task.status == .completed
    }
    
    func completeButtonTapped() {
        task.status = task.status == .completed ? .todo : .completed
        try? managedObjectContext.save()
        
        isCompleted = task.status == .completed
    }
}
