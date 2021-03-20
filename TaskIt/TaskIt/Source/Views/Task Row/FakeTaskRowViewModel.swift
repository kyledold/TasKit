//
//  FakeTaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

class FakeTaskRowViewModel: TaskRowViewModelProtocol {
    
    var isComplete = false
    var id = UUID()
    var taskTitle = "This is a fake title"
    var task = Task()
}
