//
//  FakeTaskRowViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

class FakeTaskRowViewModel: TaskRowViewModelProtocol {
    
    var isComplete = false
    var id = UUID()
    var title = "This is a fake title"
    var time: String? = "17:00"
    var subTasksCompletionPercentage: Double? = 20
    var task = Task()
}
