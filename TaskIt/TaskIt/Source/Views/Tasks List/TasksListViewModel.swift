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
    
    let titleText = NSLocalizedString("tasks.title", comment: "Tasks title")
    var createTaskButtonText = NSLocalizedString("tasks.create_task", comment: "Create button title")
    
    lazy var newTaskViewModel: NewTaskViewModel = {
        let newTaskViewModel = NewTaskViewModel(managedObjectContext: managedObjectContext)
        newTaskViewModel.onTaskAdded = { [weak self] in
            self?.fetchTasks()
        }
        
        return newTaskViewModel
    }()
    
    private unowned let coordinator: TaskItCoordinator
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(coordinator: TaskItCoordinator, managedObjectContext: NSManagedObjectContext) {
        self.coordinator = coordinator
        self.managedObjectContext = managedObjectContext
        self.taskViewModels = []
    }
    
    // MARK: - Functions
    
    func fetchTasks() {
        let taskModels = Task.fetchAll(viewContext: managedObjectContext)
        taskViewModels = taskModels.map { return TaskRowViewModel(task: $0, managedObjectContext: managedObjectContext) }
    }
    
    func open(_ rowViewModel: RowViewModel) {
        coordinator.open(rowViewModel)
    }
    
    func settingsButtonTapped() {
        coordinator.openSettings()
    }
    
    func calendarButtonTapped() {
        coordinator.openCalendar()
    }
}
