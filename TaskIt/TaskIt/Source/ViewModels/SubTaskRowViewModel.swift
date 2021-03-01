//
//  SubTaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation

class SubTaskRowViewModel: SubTaskRowViewModelProtocol {
    
    var id: UUID { return subTask.unwrappedId }
    var subTaskTitle: String { return subTask.unwrappedTitle}
    
    @Published var isComplete = false
    
    private let subTask: SubTask
    
    init(subTask: SubTask) {
        self.subTask = subTask
    }
}
