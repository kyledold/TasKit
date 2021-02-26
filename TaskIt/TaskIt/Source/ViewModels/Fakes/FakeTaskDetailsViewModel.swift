//
//  FakeTaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 21/02/2021.
//

import Foundation

class FakeTaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    var titleText = "This is a fake title"
    var priority = Priority.medium
    var submitButtonText = "Complete task"
    var cancelButtonText = "cancel"
    var actionSheetTitle = "Delete task?"
    var deleteText = "Delete"
    var actionSheetMessage = "Are you sure you want to delete this task?"

    var task = Task()
    
    func deleteButtonTapped(_ completion: @escaping EmptyClosure) {}
    func submitButtonTapped(_ completion: @escaping EmptyClosure) {}
}
