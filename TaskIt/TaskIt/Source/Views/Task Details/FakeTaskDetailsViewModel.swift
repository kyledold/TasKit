//
//  FakeTaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import CoreData
import Foundation

class FakeTaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    var taskName = String.empty
    var dueDate = Date()
    var isComplete = false
    var taskNotes = "This is the task notes"
    var taskNamePlaceholderText = "Task name"
    var taskNotesPlaceholderText = "Write notes here..."
    var taskDateText = "Date"
    var deleteAlertTitleText = "Delete task"
    var deleteAlertMessageText = "Are you sure you want to delete this task?"
    var deleteButtonText = "Delete"
    
    var subTaskListViewModel = SubTaskListViewModel(
        task: Task(),
        managedObjectContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    )
    
    func deleteButtonTapped(_ completion: @escaping EmptyClosure) { }
}
