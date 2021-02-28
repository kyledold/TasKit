//
//  TaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import CoreData
import Foundation

class TaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    typealias RowViewModel = SubTaskRowViewModel
    
    // MARK: - Properties
    
    @Published var taskName = String.empty
    @Published var priority = Priority.none
    @Published var dueDate = Date()
    @Published var isComplete = false
    @Published var taskNotes = String.empty
    @Published var subTaskModels: [SubTaskRowViewModel]
    
    var taskNamePlaceholderText = NSLocalizedString("task_details.task_name_placeholder", comment: "Task name textfield placeholder")
    var taskDateText = NSLocalizedString("task_details.date", comment: "Date picker description")
    var taskNotesPlaceholderText = NSLocalizedString("task_details.task_notes_placeholder", comment: "Task notes text editor placeholder")
    var submitButtonText: String {
        guard task == nil else { return NSLocalizedString("task_details.save_changes", comment: "submit button title") }
        
        return NSLocalizedString("task_details.create", comment: "submit button title")
    }
    
    private let onChange: EmptyClosure
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task?
    
    // MARK: - Initialisation
    
    init(
        task: Task? = nil,
        onChange: @escaping EmptyClosure,
        managedObjectContext: NSManagedObjectContext
    ) {
        self.task = task
        self.onChange = onChange
        self.managedObjectContext = managedObjectContext
        
        self.subTaskModels = task?.subTasksArray?.compactMap { SubTaskRowViewModel(subTask: $0) } ?? []
    }
    
    // MARK: - Functions
    
    func onAppear() {
        taskName = .empty
        priority = .none
    }
    
    func addNewTaskTapped(_ completion: @escaping EmptyClosure) {
        Task.createNewTask(
            taskName: taskName,
            priority: priority,
            dueDate: dueDate,
            viewContext: managedObjectContext
        )

        onChange()
        completion()
    }
}
