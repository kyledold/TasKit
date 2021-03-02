//
//  TaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import CoreData
import Foundation

class TaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var taskName = String.empty
    @Published var priority = Priority.none
    @Published var dueDate = Date()
    @Published var isComplete = false
    @Published var taskNotes = String.empty
    
    var taskNamePlaceholderText = NSLocalizedString("task_details.task_name_placeholder", comment: "Task name textfield placeholder")
    var taskNotesPlaceholderText = NSLocalizedString("task_details.task_notes_placeholder", comment: "Task notes text editor placeholder")
    var taskDateText = NSLocalizedString("task_details.date", comment: "Date picker description")
    var submitButtonText: String { return NSLocalizedString("task_details.create", comment: "submit button title") }
    
    var subTaskListViewModel: SubTaskListViewModel
    
    private let onChange: EmptyClosure
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task
    
    // MARK: - Initialisation
    
    init(
        task: Task?,
        onChange: @escaping EmptyClosure,
        managedObjectContext: NSManagedObjectContext
    ) {
        self.task = task ?? Task(context: managedObjectContext)
        self.managedObjectContext = managedObjectContext
        self.onChange = onChange
        self.subTaskListViewModel = SubTaskListViewModel(task: self.task, managedObjectContext: managedObjectContext)
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
