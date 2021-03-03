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
    var priority = Priority.none
    var dueDate = Date()
    var isComplete = false
    var taskNotes = "This is the task notes"
    var taskNamePlaceholderText = "Task name"
    var taskNotesPlaceholderText = "Write notes here..."
    var taskDateText = "Date"
    var submitButtonText = "Create"
    var isSubmitButtonDisabled = false
    var subTaskListViewModel = SubTaskListViewModel(
        task: Task(),
        managedObjectContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    )
    
    func onAppear() {}
    func onDisappear() {}
    func submitButtonTapped(_ completion: @escaping EmptyClosure) { }
}
