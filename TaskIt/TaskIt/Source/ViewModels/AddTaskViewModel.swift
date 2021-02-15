//
//  AddTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Foundation

class AddTaskViewModel: AddTaskViewModelProtocol {
    
    @Published var taskName = ""
    
    var taskNamePlaceholder = NSLocalizedString("add_task.task_name_placeholder", comment: "Task name")
    
}
