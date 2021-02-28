//
//  FakeSubTaskListViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation

class FakeSubTaskListViewModel: SubTaskListViewModelProtocol {

    typealias RowViewModel = FakeSubTaskRowViewModel
    
    var subTaskNamePlaceholderText = "Subtask name"
    var addSubTaskButtonText = "Add subtask"
    var newSubTaskName = ""
    
    var subTaskModels: [RowViewModel] = [
        FakeSubTaskRowViewModel(),
        FakeSubTaskRowViewModel(),
        FakeSubTaskRowViewModel()
    ]
    
    func addNewSubTaskButtonTapped(_ completion: @escaping EmptyClosure) {}
}
