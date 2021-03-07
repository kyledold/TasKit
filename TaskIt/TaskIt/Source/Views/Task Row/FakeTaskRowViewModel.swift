//
//  FakeTaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

class FakeTaskRowViewModel: TaskRowViewModelProtocol {
    
    var id = UUID()
    var taskTitle = "This is a fake title"
    var dayOfTheWeekText = "FRI"
    var dateText = "25"
    var monthText = "Nov"
    var isCompleted = false
    var task = Task()
}
