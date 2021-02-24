//
//  FakeTasksListViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Foundation

class FakeTasksListViewModel: TasksListViewModelProtocol {
    
    typealias RowViewModel = FakeTaskRowViewModel
    
    var titleText = "Tasks"
    var createTaskButtonText = "Create task"
    
    var taskViewModels: [RowViewModel] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    
    var selectedStatusFilter = Status.todo
    
    func fetchTasks() {}
    func didChangeStatusFilter(status: Status) {}
}
