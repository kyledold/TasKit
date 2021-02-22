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
    var completeTaskButtonText = "Complete task"
    var cancelButtonText = "cancel"
    var task = Task()
    
    func deleteTask(_ completion: @escaping EmptyClosure) {}
    func completeTask(_ completion: @escaping EmptyClosure) {}
}
