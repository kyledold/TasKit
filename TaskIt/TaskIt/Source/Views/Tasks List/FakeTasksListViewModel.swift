//
//  FakeTasksListViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import CoreData
import Foundation

class FakeTasksListViewModel: TasksListViewModelProtocol {
    
    typealias RowViewModel = FakeTaskRowViewModel
    
    var titleText = "Tasks"
    var createTaskButtonText = "Create task"
    var newTaskViewModel = NewTaskViewModel(managedObjectContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    
    var taskViewModels: [RowViewModel] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    
    var selectedStatusFilter = Status.todo
    
    func fetchTasks() {}
    func didChangeStatusFilter(status: Status) {}
}