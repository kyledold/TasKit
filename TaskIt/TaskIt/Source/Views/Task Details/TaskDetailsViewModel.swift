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
    @Published var isSubmitButtonDisabled: Bool = false
    
    var taskNamePlaceholderText = NSLocalizedString("task_details.task_name_placeholder", comment: "Task name textfield placeholder")
    var taskNotesPlaceholderText = NSLocalizedString("task_details.task_notes_placeholder", comment: "Task notes text editor placeholder")
    var taskDateText = NSLocalizedString("task_details.date", comment: "Date picker description")
    var submitButtonText = NSLocalizedString("task_details.update", comment: "submit button title")
    
    var subTaskListViewModel: SubTaskListViewModel
    
    private let onChange: EmptyClosure
    private var subscribers: Set<AnyCancellable> = []
    private let notificationCenter = NotificationCenter.default
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task
    
    // MARK: - Initialisation
    
    init(task: Task, onChange: @escaping EmptyClosure, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        self.onChange = onChange
        self.subTaskListViewModel = SubTaskListViewModel(task: self.task, managedObjectContext: managedObjectContext)
        
        taskName = task.unwrappedTitle
        dueDate = task.unwrappeDueDate
        isComplete = task.status == .completed
        taskNotes = task.unwrappedNotes
        
        addObservers()
    }
    
    // MARK: - Functions
    
    func submitButtonTapped(_ completion: @escaping EmptyClosure) {
        
        Task.updateTask(
            task: task,
            taskName: taskName,
            dueDate: dueDate,
            taskNotes: taskNotes,
            viewContext: managedObjectContext
        )

        onChange()
        notificationCenter.post(name: .taskUpdated, object: nil)
        completion()
    }
    
    private func addObservers() {
        $taskName.sink { [weak self] taskName in
            self?.isSubmitButtonDisabled = taskName.isBlank
        }.store(in: &subscribers)
        
        $isComplete.dropFirst().sink { [weak self] isComplete in
            guard let task = self?.task else { return }
            guard let managedObjectContext = self?.managedObjectContext else { return }
            
            Task.updateStatus(task: task, newStatus: isComplete ? .completed : .todo, viewContext: managedObjectContext)
        }.store(in: &subscribers)
    }
}
