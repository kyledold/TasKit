//
//  TaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

class TaskRowViewModel: TaskRowViewModelProtocol {
    
    var id: Int { return 0 }
    
    var titleText: String { return task.title ?? .empty }
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
}
