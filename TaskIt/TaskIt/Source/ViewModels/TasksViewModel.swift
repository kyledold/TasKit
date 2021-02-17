//
//  TasksViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 14/02/2021.
//

import CoreData
import Foundation

class TasksViewModel: TasksViewModelProtocol {
    
    let titleText = NSLocalizedString("tasks.title", comment: "Tasks title")
    
    @Published private(set) var taskViewModels: [TaskRowViewModelProtocol]
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.taskViewModels = []
    }
    
    func fetchTasks() {
        let taskModels = Task.fetchAll(viewContext: managedObjectContext)
        taskViewModels = taskModels.map { return TaskRowViewModel(task: $0) }
    }
}
