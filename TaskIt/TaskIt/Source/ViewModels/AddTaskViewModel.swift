//
//  AddTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import CoreData
import Foundation
import NetworkKit

class AddTaskViewModel: AddTaskViewModelProtocol {
    
    @Published var taskName = String.empty
    
    var taskNamePlaceholder = NSLocalizedString("add_task.task_name_placeholder", comment: "Task name textfield placeholder")
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func addNewTaskTapped(_ completion: @escaping EmptyClosure) {
        let task = Task(context: managedObjectContext)
        task.name = taskName
        try? managedObjectContext.save()
    }
}
