//
//  TasksListViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 14/02/2021.
//

import Combine
import CoreData
import Foundation

class TasksListViewModel: TasksListViewModelProtocol {
    
    typealias RowViewModel = TaskRowViewModel
    
    // MARK: - Properties
    
    @Published var selectedDate: Date
    @Published var selectedDateText: String
    @Published var showNewTaskView: Bool
    @Published var showCalendarView: Bool
    @Published var showSortButton: Bool
    @Published var taskViewModels: [RowViewModel]
    
    let createTaskButtonText = NSLocalizedString("task_list.create_task", comment: "Create button title")
    let emptyListText = NSLocalizedString("task_list.no_tasks", comment: "Empty list text")
    
    private let notificationCenter = NotificationCenter.default
    private let calendar = Calendar.current
    private var subscribers: Set<AnyCancellable> = []
    private unowned let coordinator: TaskItCoordinator
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(
        selectedDate: Date = Date(),
        coordinator: TaskItCoordinator,
        managedObjectContext: NSManagedObjectContext
    ) {
        self.coordinator = coordinator
        self.managedObjectContext = managedObjectContext
        
        self.selectedDate = selectedDate
        self.selectedDateText = NSLocalizedString("task_list.today", comment: "Selcted date title")
        self.taskViewModels = []
        self.showNewTaskView = false
        self.showCalendarView = false
        self.showSortButton = false
        
        addObservers()
        fetchTasks()
    }
    
    // MARK: - View Events
    
    func viewWillEnterForeground() {
        selectedDateText = getReadableDate(from: selectedDate)
        fetchTasks()
    }
    
    // MARK: - Task Operations
    
    private func fetchTasks() {
        let selectedDatesTaskModels = Task.fetchAll(for: selectedDate, viewContext: managedObjectContext)
        taskViewModels = selectedDatesTaskModels.map { task in
            return TaskRowViewModel(
                task: task,
                managedObjectContext: managedObjectContext,
                onChangeCompletion: { [weak self] isComplete in
                    self?.updateTaskCompletionStatus(task, isComplete: isComplete)
                }
            )
        }
        showSortButton = taskViewModels.count > 1
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
    
    private func updateTaskCompletionStatus(_ task: Task, isComplete: Bool) {
        Task.updateCompletionStatus(
            task: task,
            isComplete: isComplete,
            viewContext: managedObjectContext
        )
    }
    
    // MARK: - Events
    
    func taskRowTapped(_ rowViewModel: RowViewModel) {
        coordinator.showTaskDetails(rowViewModel, onDateChanged: { [weak self] in
            self?.fetchTasks()
        })
    }
    
    func createTaskButtonTapped() {
        newTaskViewModel.selectedDate = selectedDate
        newTaskViewModel.index = indexForNewTask()
        showNewTaskView = true
    }
    
    func calendarButtonTapped() {
        calendarViewModel.selectedDate = selectedDate
        showCalendarView = true
    }
    
    func settingsButtonTapped() {
        coordinator.showSettings()
    }
    
    // MARK: - Convenience
    
    private func indexForNewTask() -> Int {
        let sortedTasksByIndex = taskViewModels.sorted(by: { (task1, task2) in
            task1.task.index > task2.task.index
        })
        
        var newTaskIndex = 0
        if let currentLastIndex = sortedTasksByIndex.first?.task.index {
            newTaskIndex = Int(currentLastIndex) + 1
        } else {
            newTaskIndex = taskViewModels.count
        }

        return newTaskIndex
    }
    
    // MARK: - Observers
    
    private func addObservers() {
        $selectedDate.dropFirst().sink { [weak self] newSelectedDate in
            guard let self = self else { return }
            self.selectedDateText = self.getReadableDate(from: newSelectedDate)
        }.store(in: &subscribers)
        
        notificationCenter.publisher(for: Notification.Name.NSManagedObjectContextObjectsDidChange, object: managedObjectContext)
            .sink { [weak self] notification in
                guard let userInfo = notification.userInfo else { return }
                guard let updates = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject> else { return }
                
                for update in updates {
                    if let updatedTask = update as? Task {
                        
                        if self?.taskViewModels.contains(where: { $0.taskId == updatedTask.id }) == true {
                            self?.fetchTasks()
                        }
                    }
                }
        }.store(in: &subscribers)
    }
    
    private func getReadableDate(from date: Date) -> String {
        
        // Return "Today" if selected date is today
        guard !calendar.isDate(Date(), inSameDayAs: date) else {
            return NSLocalizedString("task_list.today", comment: "Selcted date title")
        }
        
        // Return "Tomorrow" if selected date is today
        guard !calendar.isDate(Date().addDays(numberOfDays: 1), inSameDayAs: date) else {
            return NSLocalizedString("task_list.tomorrow", comment: "Selcted date title")
        }
        
        let day = date.get(.day)
        let dayOfTheWeek = date.dayOfTheWeek
        let month = date.month
        return "\(dayOfTheWeek) \(day) \(month)"
    }

    // MARK: - Child ViewModels
    
    lazy var newTaskViewModel: NewTaskViewModel = {
        let newTaskViewModel = NewTaskViewModel(
            selectedDate: selectedDate,
            index: indexForNewTask(),
            managedObjectContext: managedObjectContext
        )
        
        newTaskViewModel.onTaskAdded = { [weak self] in
            self?.fetchTasks()
        }
        
        return newTaskViewModel
    }()
    
    lazy var calendarViewModel: CalendarViewModel = {
        let calendarViewModel = CalendarViewModel(selectedDate: selectedDate)
        calendarViewModel.onDateSelected = { [weak self] selectedDate in
            self?.selectedDate = selectedDate
            self?.showCalendarView = false
            self?.fetchTasks()
        }
        
        return calendarViewModel
    }()
}

