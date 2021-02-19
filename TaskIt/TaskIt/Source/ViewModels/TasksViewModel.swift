//
//  TasksViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 14/02/2021.
//

import CoreData
import Foundation

class TasksViewModel: TasksViewModelProtocol {
    
    typealias RowViewModel = TaskRowViewModel
    
    // MARK: Properties
    
    let titleText = NSLocalizedString("tasks.title", comment: "Tasks title")
    
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
    
    func deleteTask(at indexSet: IndexSet) {
        
        let taskViewModelsToDelete = indexSet.map { self.taskViewModels[$0] }
        
        for taskViewModel in taskViewModelsToDelete {
            Task.deleteTask(with: taskViewModel.id, viewContext: managedObjectContext)
        }
        
        fetchTasks()
    }
    
    func didChangeStatusFilter(status: Status) {
        selectedStatusFilter = status
        fetchTasks()
    }
}
