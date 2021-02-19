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
    var priority = Priority.medium
    var isCompleted = false
    
    func completeButtonTapped() {}
}
