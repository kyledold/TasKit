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
    var showNewTaskView = false
    var showCalendarView = false
    var selectedDateText = "Today"
    var createTaskButtonText = "Create task"
    var newTaskViewModel = NewTaskViewModel(selectedDate: Date(), managedObjectContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    var calendarViewModel = CalendarViewModel(selectedDate: Date())

    var taskViewModels: [RowViewModel] = [
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel(),
        FakeTaskRowViewModel()
    ]
    
    func fetchTasks() {}
    func deleteTask(at indexSet: IndexSet) {}
    func moveTask(from source: IndexSet, to destination: Int) {}
    func taskRowTapped(_ rowViewModel: RowViewModel) {}
    func createTaskButtonTapped() {}
    func calendarButtonTapped() {}
    func settingsButtonTapped() {}
}
