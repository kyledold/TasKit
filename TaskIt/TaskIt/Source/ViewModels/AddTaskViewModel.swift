//
//  AddTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import CoreData
import Foundation

class AddTaskViewModel: AddTaskViewModelProtocol {
    
    @Published var taskName = String.empty
    
    var taskNamePlaceholder = NSLocalizedString("add_task.task_name_placeholder", comment: "Task name textfield placeholder")
    
    private var onTaskAdded: EmptyClosure
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext, onTaskAdded: @escaping EmptyClosure) {
        self.managedObjectContext = managedObjectContext
        self.onTaskAdded = onTaskAdded
    }
    
    func addNewTaskTapped(_ completion: @escaping EmptyClosure) {
        let task = Task(context: managedObjectContext)
        
        task.title = taskName
        task.status = .todo
        task.priority = .low
        
        try? managedObjectContext.save()
        
        onTaskAdded()
        completion()
    }
}
