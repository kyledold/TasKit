//
//  TaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

class TaskRowViewModel: TaskRowViewModelProtocol {
    
    var id: Int { return 0 }
    
    var titleText: String
    var priority: Priority
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
        
        self.titleText = task.title ?? .empty
        self.priority = task.priority
    }
}
