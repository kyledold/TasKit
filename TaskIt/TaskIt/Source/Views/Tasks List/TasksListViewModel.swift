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
    @Published private(set) var hasOverdueTasks: Bool
    @Published private(set) var overdueTaskViewModels: [RowViewModel]
    @Published private(set) var currentTaskViewModels: [RowViewModel]
    
    let overdueSectionTitle = NSLocalizedString("task_list.overdue", comment: "Title for overdue section")
    let selectedDateText = NSLocalizedString("task_list.today", comment: "Text for selected date")
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
        self.overdueTaskViewModels = []
        self.currentTaskViewModels = []
        self.hasOverdueTasks = false
    }
    
    // MARK: - Functions
    
    func fetchTasks() {
        let overdueTaskModels = Task.fetchAllOverdue(for: selectedDate, viewContext: managedObjectContext)
        let selectedDatesTaskModels = Task.fetchAll(for: selectedDate, viewContext: managedObjectContext)
        
        overdueTaskViewModels = overdueTaskModels.map { return TaskRowViewModel(task: $0, managedObjectContext: managedObjectContext) }
        hasOverdueTasks = !overdueTaskViewModels.isEmpty
        
        currentTaskViewModels = selectedDatesTaskModels.map { return TaskRowViewModel(task: $0, managedObjectContext: managedObjectContext) }
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

