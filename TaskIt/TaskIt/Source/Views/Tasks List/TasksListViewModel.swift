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
    
    @Published var selectedDate: Date
    @Published private(set) var taskViewModels: [RowViewModel]
    
    let titleText = NSLocalizedString("task_list.tasks", comment: "Title")
    let createTaskButtonText = NSLocalizedString("task_list.create_task", comment: "Create button title")
    
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
        self.selectedDate = Date()
        self.coordinator = coordinator
        self.managedObjectContext = managedObjectContext
        self.taskViewModels = []
    }
    
    // MARK: - Functions
    
    func fetchTasks() {
        let selectedDatesTaskModels = Task.fetchAll(viewContext: managedObjectContext)
        taskViewModels = selectedDatesTaskModels.map { return TaskRowViewModel(task: $0, managedObjectContext: managedObjectContext) }
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

