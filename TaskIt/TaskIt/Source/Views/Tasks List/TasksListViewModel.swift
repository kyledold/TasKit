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
    
    let selectedDateText = NSLocalizedString("task_list.today", comment: "Title")
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
        let selectedDatesTaskModels = Task.fetchAll(for: selectedDate, viewContext: managedObjectContext)
        taskViewModels = selectedDatesTaskModels.map { return TaskRowViewModel(task: $0, managedObjectContext: managedObjectContext) }
    }
    
    func deleteTask(at indexSet: IndexSet) {
        
        let tasksToDelete = indexSet.map { taskViewModels[$0].task }
        
        tasksToDelete.forEach { task in
            Task.deleteTask(task: task, viewContext: managedObjectContext)
        }
        
        fetchTasks()
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        
        var revisedTasks = taskViewModels.map { $0.task }
        revisedTasks.move(fromOffsets: source, toOffset: destination)
        
        Task.updateOrderOfTasks(revisedTasks, viewContext: managedObjectContext)
        
        fetchTasks()
    }
    
    func taskRowTapped(_ rowViewModel: RowViewModel) {
        coordinator.showTaskDetails(rowViewModel)
    }
    
    func settingsButtonTapped() {
        coordinator.showSettings()
    }
    
    func calendarButtonTapped() {
        coordinator.showCalendar()
    }
}

