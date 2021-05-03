//
//  FakeSubTaskListViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation

class FakeSubTaskListViewModel: SubTaskListViewModelProtocol {

    typealias RowViewModel = FakeSubTaskRowViewModel
    
    var headerText = "Sub-tasks"
    var subTaskNamePlaceholderText = "Sub-task name"
    var addSubTaskButtonText = "Add subtask"
    var addButtonText = "Add"
    var doneButtonText = "Done"
    var cancelButtonText = "Cancel"
    var editButtonText = "Edit"
    var newSubTaskName = ""
    var isListInEditMode = false
    
    var subTaskModels: [RowViewModel] = [
        FakeSubTaskRowViewModel(),
        FakeSubTaskRowViewModel(),
        FakeSubTaskRowViewModel()
    ]
    
    func deleteSubTask(at indexSet: IndexSet) {}
    func moveSubTask(from source: IndexSet, to destination: Int) {}
    func addSubTaskButtonTapped(_ completion: @escaping EmptyClosure) {}
    func editButtonTapped() {}
    func cancelButtonTapped() {}
}
