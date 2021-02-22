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
    @Published var dueDate = Date()
    
    var taskNamePlaceholderText = NSLocalizedString("add_task.task_name_placeholder", comment: "Task name textfield placeholder")
    var taskDateText = NSLocalizedString("add_task.date", comment: "Date picker description")
    var cancelButtonText = NSLocalizedString("general.cancel", comment: "cancel button title")
    var submitButtonText: String {
        guard task == nil else { return NSLocalizedString("add_task.save_changes", comment: "submit button title") }
        
        return NSLocalizedString("add_task.create", comment: "submit button title")
    }
    
    private var onTaskAdded: EmptyClosure
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task?
    
    init(
        task: Task? = nil,
        managedObjectContext: NSManagedObjectContext,
        onTaskAdded: @escaping EmptyClosure
    ) {
        self.task = task
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
        task.priority = priority
        task.dueDate = dueDate
        
        try? managedObjectContext.save()
        
        onTaskAdded()
        completion()
    }
}
