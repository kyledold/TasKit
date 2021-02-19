//
//  FakeAddTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Foundation

class FakeAddTaskViewModel: AddTaskViewModelProtocol {

    var taskName = String.empty
    var priority = Priority.none
    var dueDate = Date()
    var taskNamePlaceholderText = "Task name"
    var taskDateText = "Date"
    
    func onAppear() {}
    func addNewTaskTapped(_ completion: @escaping EmptyClosure) { }
}
