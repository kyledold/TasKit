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
    
    // MARK: - Properties
    
    @Published private(set) var taskViewModels: [RowViewModel]
    @Published var selectedStatusFilter = Status.todo
    
    let titleText = NSLocalizedString("tasks.title", comment: "Tasks title")
    var createTaskButtonText = NSLocalizedString("tasks.create_task", comment: "Create button title")
    
    lazy var newTaskViewModel: NewTaskViewModel = {
        let newTaskViewModel = NewTaskViewModel(managedObjectContext: managedObjectContext)
        newTaskViewModel.onTaskAdded = { [weak self] in
            self?.fetchTasks()
        }
        
        return newTaskViewModel
    }()
    
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.taskViewModels = []
    }
    
    // MARK: - Functions
    
    func fetchTasks() {
        let taskModels = Task.fetchAll(with: selectedStatusFilter, viewContext: managedObjectContext)
        taskViewModels = taskModels.map { return TaskRowViewModel(task: $0, managedObjectContext: managedObjectContext) }
    }
    
    func didChangeStatusFilter(status: Status) {
        selectedStatusFilter = status
        fetchTasks()
    }
}
