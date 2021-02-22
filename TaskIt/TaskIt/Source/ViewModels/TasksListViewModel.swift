//
//  TasksListViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 14/02/2021.
//

import CoreData
import Foundation

class TasksListViewModel: TasksListViewModelProtocol {
    
    typealias RowViewModel = TaskRowViewModel
    
    // MARK: Properties
    
    let titleText = NSLocalizedString("tasks.title", comment: "Tasks title")
    var createTaskButtonText = NSLocalizedString("tasks.creat_task", comment: "Create button title")
    
    @Published private(set) var taskViewModels: [RowViewModel]
    @Published var selectedStatusFilter = Status.todo
    
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: Initialisation
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.taskViewModels = []
    }
    
    // MARK: Functions
    
    func fetchTasks() {
        
        var taskModels: [Task]
        if selectedStatusFilter == .todo {
            taskModels = Task.fetchAllToDoTasks(viewContext: managedObjectContext)
        } else {
            taskModels = Task.fetchAllCompletedTasks(viewContext: managedObjectContext)
        }
        
        taskViewModels = taskModels.map { return TaskRowViewModel(task: $0, managedObjectContext: managedObjectContext) }
    }
    
    func didChangeStatusFilter(status: Status) {
        selectedStatusFilter = status
        fetchTasks()
    }
}
