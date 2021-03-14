//
//  TaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import CoreData
import Foundation

class TaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var taskName = String.empty
    @Published var dueDate = Date()
    @Published var isComplete = false
    @Published var taskNotes = String.empty
    
    var taskNamePlaceholderText = NSLocalizedString("task_details.task_name_placeholder", comment: "Task name textfield placeholder")
    var taskNotesPlaceholderText = NSLocalizedString("task_details.task_notes_placeholder", comment: "Task notes text editor placeholder")
    var taskDateText = NSLocalizedString("task_details.date", comment: "Date picker description")
    
    var deleteAlertTitleText = NSLocalizedString("task_details.delete_alert.title", comment: "Delete alert title")
    var deleteAlertMessageText = NSLocalizedString("task_details.delete_alert.message", comment: "Delete alert message")
    var deleteButtonText = NSLocalizedString("task_details.delete", comment: "Delete button title")
    var saveButtonText = NSLocalizedString("task_details.save", comment: "Save button title")
    
    var subTaskListViewModel: SubTaskListViewModel
    
    private var subscribers: Set<AnyCancellable> = []
    private let notificationCenter = NotificationCenter.default
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task
    
    // MARK: - Initialisation
    
    init(task: Task, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        self.subTaskListViewModel = SubTaskListViewModel(task: self.task, managedObjectContext: managedObjectContext)
        
        taskName = task.unwrappedTitle
        dueDate = task.unwrappeDueDate
        isComplete = task.status == .completed
        taskNotes = task.unwrappedNotes
        
        addObservers()
    }
    
    // MARK: - Events
    
    func deleteButtonTapped(_ completion: @escaping EmptyClosure) {
        Task.deleteTask(task: task, viewContext: managedObjectContext)
        
        notificationCenter.post(name: .taskDeleted, object: nil)
        completion()
    }
    
    // MARK: - Observers
    
    private func addObservers() {
        
        $isComplete.dropFirst().sink { [weak self] isComplete in
            self?.updateCompletionStatus(isComplete)
        }.store(in: &subscribers)
        
        $taskName.dropFirst().sink { [weak self] taskName in
            self?.updateTaskName(taskName)
        }.store(in: &subscribers)
        
        $dueDate.dropFirst().sink { [weak self] dueDate in
            self?.updateTaskDueDate(dueDate)
        }.store(in: &subscribers)
        
        $taskNotes.dropFirst().sink { [weak self] taskNotes in
            self?.updateTaskNotes(taskNotes)
        }.store(in: &subscribers)
    }

    // MARK: - CoreDate Operations
    
    private func updateTaskNotes(_ taskNotes: String) {
        Task.updateNotes(
            task: task,
            notes: taskNotes,
            viewContext: managedObjectContext
        )
    }
    
    private func updateTaskDueDate(_ dueDate: Date) {
        Task.updateDueDate(
            task: task,
            dueDate: dueDate,
            viewContext: managedObjectContext
        )
    }
    
    private func updateTaskName(_ taskName: String) {
        Task.updateTitle(
            task: task,
            title: taskName,
            viewContext: managedObjectContext
        )
    }
    
    private func updateCompletionStatus(_ isComplete: Bool) {
        Task.updateStatus(
            task: task,
            newStatus: isComplete ? .completed : .todo,
            viewContext: managedObjectContext
        )
    }
}
