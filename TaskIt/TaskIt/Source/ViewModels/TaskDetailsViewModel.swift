//
//  TaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 21/02/2021.
//

import Foundation

class TaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    var titleText: String { task.title ?? .empty }
    var priority: Priority { task.priority }
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
}
