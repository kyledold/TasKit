//
//  TasksListViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import Foundation

protocol TasksListViewModelProtocol: ObservableObject {
    
    associatedtype RowViewModel: TaskRowViewModelProtocol
    
    var taskViewModels: Array<RowViewModel> { get }
    
    var selectedDate: Date { get set }
    var selectedDateText: String { get }
    var showNewTaskView: Bool { get set }
    var showCalendarView: Bool { get set }
    var showSortButton: Bool { get }
    var createTaskButtonText: String { get }
    var emptyListText: String { get }
    var newTaskViewModel: NewTaskViewModel { get }
    var calendarViewModel: CalendarViewModel { get }
    
    func fetchTasks()
    func deleteTask(at indexSet: IndexSet)
    func moveTask(from source: IndexSet, to destination: Int)
    
    func taskRowTapped(_ rowViewModel: RowViewModel)
    func createTaskButtonTapped()
    func calendarButtonTapped()
    func settingsButtonTapped()
}
