//
//  FakeNewTaskViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 06/03/2021.
//

import Foundation

class FakeNewTaskViewModel: NewTaskViewModelProtocol {
    
    var taskName = ""
    var selectedDate = Date()
    var index = 0
    var isCreateButtonDisabled = false
    var taskNamePlaceholder = "Type new task name here..."
    
    func createTaskButtonTapped(_ completion: @escaping EmptyClosure) {}
}
