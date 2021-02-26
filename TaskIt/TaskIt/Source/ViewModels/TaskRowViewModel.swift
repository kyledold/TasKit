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
    
    var id: UUID { return task.id ?? UUID() }
    var titleText: String { task.title ?? .empty }
    var priority: Priority { task.priority }
    
    var dayOfTheWeekText: String {
        guard let dueDate = task.dueDate else { return .empty}
        return dueDate.dayOfTheWeek.uppercased()
    }
    
    var dateText: String {
        guard let dueDate = task.dueDate else { return .empty}
        return "\(dueDate.get(.day))"
    }
    
    var monthText: String {
        guard let dueDate = task.dueDate else { return .empty}
        return dueDate.month
    }
    
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
