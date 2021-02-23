//
//  FakeTaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

class FakeTaskRowViewModel: TaskRowViewModelProtocol {
    
    var id = UUID()
    var titleText = "This is a fake title"
    var dateText = "25"
    var monthText = "Nov"
    var priority = Priority.medium
    var isCompleted = false
    var task = Task()
    
    func completeButtonTapped() {}
}
