//
//  FakeTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Foundation

class FakeTaskViewModel: TasksViewModelProtocol {
    
    var titleText = "Tasks"
    var taskViewModels: [TaskRowViewModelProtocol] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    
    func fetchTasks() {}
    func deleteTask(at indexSet: IndexSet) {}
}
