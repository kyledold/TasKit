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
    @Published var priority = Priority.none
    
    var taskNamePlaceholder = NSLocalizedString("add_task.task_name_placeholder", comment: "Task name textfield placeholder")
    
    private var onTaskAdded: EmptyClosure
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext, onTaskAdded: @escaping EmptyClosure) {
        self.managedObjectContext = managedObjectContext
        self.onTaskAdded = onTaskAdded
    }
    
    func onAppear() {
        taskName = .empty
        priority = .none
    }
    
    func addNewTaskTapped(_ completion: @escaping EmptyClosure) {
        let task = Task(context: managedObjectContext)
        
        task.title = taskName
        task.status = .todo
        task.priority = priority
        
        try? managedObjectContext.save()
        
        onTaskAdded()
        completion()
    }
}
