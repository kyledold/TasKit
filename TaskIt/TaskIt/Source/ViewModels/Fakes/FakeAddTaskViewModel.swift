//
//  FakeAddTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

class FakeAddTaskViewModel: AddTaskViewModelProtocol {

    var taskName = String.empty
    var priority = Priority.none
    var taskNamePlaceholder = "Task name"
    
    func onAppear() {}
    func addNewTaskTapped(_ completion: @escaping EmptyClosure) { }
}
