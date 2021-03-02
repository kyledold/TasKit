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
    
    var id: UUID { return task.unwrappedId }
    var taskTitle: String { task.unwrappedTitle }
    var priority: Priority { task.priority }
    var dayOfTheWeekText: String { return task.unwrappeDueDate.dayOfTheWeek.uppercased() }
    var dateText: String { return "\(task.unwrappeDueDate.get(.day))" }
    var monthText: String { return task.unwrappeDueDate.month }
    
    @Published var isCompleted: Bool
    
    private(set) var task: Task
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(task: Task, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        
        self.isCompleted = task.status == .completed
    }
    
    // MARK: - Functions
    
    func completeButtonTapped() {
        task.status = task.status == .completed ? .todo : .completed
        try? managedObjectContext.save()
        
        isCompleted = task.status == .completed
    }
}
