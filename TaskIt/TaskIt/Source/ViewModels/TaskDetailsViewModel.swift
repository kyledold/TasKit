//
//  TaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 21/02/2021.
//

import CoreData
import Foundation

class TaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    var titleText: String { task.title ?? .empty }
    var priority: Priority { task.priority }
    var cancelButtonText = NSLocalizedString("general.cancel", comment: "cancel button title")
    var actionSheetTitle = NSLocalizedString("task_details.action_sheet.title", comment: "action sheet title")
    var actionSheetMessage = NSLocalizedString("task_details.action_sheet.message", comment: "action sheet message")
    var deleteText = NSLocalizedString("task_details.action_sheet.delete", comment: "action sheet delete")
    var submitButtonText: String {
        if task.status == .todo {
            return NSLocalizedString("task_details.complete_task", comment: "submit button title")
        } else {
            return NSLocalizedString("task_details.undo_completion", comment: "submit button title")
        }
    }
    
    private(set) var task: Task
    private let onChange: EmptyClosure
    private let managedObjectContext: NSManagedObjectContext
    private let notificationCenter: NotificationCenter
    
    // MARK: - Initialisation
    
    init(
        task: Task,
        onChange: @escaping EmptyClosure,
        managedObjectContext: NSManagedObjectContext,
        notificationCenter: NotificationCenter = NotificationCenter.default
    ) {
        self.task = task
        self.onChange = onChange
        self.managedObjectContext = managedObjectContext
        self.notificationCenter = notificationCenter
    }
    
    // MARK: - Task operations
    
    func deleteButtonTapped(_ completion: @escaping EmptyClosure) {
        
        Task.deleteTask(task: task, viewContext: managedObjectContext)
        onChange()
        notificationCenter.post(name: .taskDeleted, object: nil)
        completion()
    }
    
    func submitButtonTapped(_ completion: @escaping EmptyClosure) {
        
        let newStatus: Status = task.status == .completed ? .todo : .completed
        Task.updateStatus(task: task, newStatus: newStatus, viewContext: managedObjectContext)
        onChange()
        
        if newStatus == .completed {
            notificationCenter.post(name: .taskCompleted, object: nil)
        } else {
            notificationCenter.post(name: .taskUpdated, object: nil)
        }

        completion()
    }
}
