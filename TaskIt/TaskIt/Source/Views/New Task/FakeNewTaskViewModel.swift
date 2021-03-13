//
//  FakeNewTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 06/03/2021.
//

import Foundation

class FakeNewTaskViewModel: NewTaskViewModelProtocol {
    
    var taskName = ""
    var isCreateButtonDisabled = false
    var selectedDate = Date()
    var taskNamePlaceholder = "Type new task name here..."
    
    func createTaskButtonTapped(_ completion: @escaping EmptyClosure) {}
}
