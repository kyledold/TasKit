//
//  FakeTasksViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Foundation

class FakeTasksViewModel: TasksViewModelProtocol {
    
    typealias RowViewModel = FakeTaskRowViewModel
    
    var titleText = "Tasks"
    var taskViewModels: [RowViewModel] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    
    var selectedStatusFilter = Status.todo
    
    func fetchTasks() {}
    func deleteTask(at indexSet: IndexSet) {}
    func didChangeStatusFilter(status: Status) {}
}
