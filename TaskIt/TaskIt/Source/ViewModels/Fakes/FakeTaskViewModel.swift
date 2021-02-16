//
//  FakeTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import NetworkKit

class FakeTaskViewModel: TasksViewModelProtocol {
    
    var titleText = "Tasks"
    var tasks: [Task] = []
    
    func fetchTasks() {}
}
