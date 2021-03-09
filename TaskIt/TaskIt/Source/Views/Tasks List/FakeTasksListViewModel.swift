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
    
    var selectedDate = Date()
    var hasOverdueTasks = false
    var selectedDateText = "Today"
    var createTaskButtonText = "Create task"
    var overdueSectionTitle = "Overdue"
    var newTaskViewModel = NewTaskViewModel(managedObjectContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    
    var overdueTaskViewModels: [RowViewModel] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    var currentTaskViewModels: [RowViewModel] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    
    func fetchTasks() {}
    func open(_ rowViewModel: RowViewModel) {}
    func settingsButtonTapped() {}
    func calendarButtonTapped() {}
}
