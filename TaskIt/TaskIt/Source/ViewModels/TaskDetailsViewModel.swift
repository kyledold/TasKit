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
    var completeTaskButtonText = NSLocalizedString("task_details.complete_task", comment: "complete button title")
    var cancelButtonText = NSLocalizedString("general.cancel", comment: "cancel button title")
    var actionSheetTitle = NSLocalizedString("task_details.action_sheet.title", comment: "action sheet title")
    var deleteText = NSLocalizedString("task_details.action_sheet.delete", comment: "action sheet delete")
    
    private(set) var task: Task
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(task: Task, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.managedObjectContext = managedObjectContext
    }
    
    // MARK: - Functions
    
    func deleteTask(_ completion: @escaping EmptyClosure) {
        guard let taskId = task.id else { return }
        
        Task.deleteTask(with: taskId, viewContext: managedObjectContext)
        completion()
    }
    
    func completeTask(_ completion: @escaping EmptyClosure) {
        completion()
    }
}
