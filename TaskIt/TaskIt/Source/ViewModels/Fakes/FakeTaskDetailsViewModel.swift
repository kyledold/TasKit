//
//  FakeTaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

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
    var cancelButtonText = "cancel"
    var submitButtonText = "Create"
    
    func onAppear() {}
    func addNewTaskTapped(_ completion: @escaping EmptyClosure) { }
}
