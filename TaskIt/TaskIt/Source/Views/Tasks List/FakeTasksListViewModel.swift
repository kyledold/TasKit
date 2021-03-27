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
    var selectedDateText = "Today"
    var showNewTaskView = false
    var showCalendarView = false
    var showSortButton = true
    var createTaskButtonText = "Create task"
    var emptyListText = "No tasks"
    var newTaskViewModel = NewTaskViewModel(selectedDate: Date(), index: 0, managedObjectContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    var calendarViewModel = CalendarViewModel(selectedDate: Date())

    var taskViewModels: [RowViewModel] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    
    func deleteTask(at indexSet: IndexSet) {}
    func moveTask(from source: IndexSet, to destination: Int) {}
    func taskRowTapped(_ rowViewModel: RowViewModel) {}
    func createTaskButtonTapped() {}
    func calendarButtonTapped() {}
    func settingsButtonTapped() {}
}
