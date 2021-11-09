//
//  FakeSubTaskRowViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation

class FakeSubTaskRowViewModel: SubTaskRowViewModelProtocol {
    
    var id = UUID()
    var subTaskId = UUID()
    var title = "This is a fake sub task title"
    var isComplete = false
    var subTask = SubTask()
}
