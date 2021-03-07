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
    var titleText: String { get }
    var createTaskButtonText: String { get }
    var newTaskViewModel: NewTaskViewModel { get }
    
    func fetchTasks()
    func open(_ rowViewModel: RowViewModel)
    func settingsButtonTapped()
    func calendarButtonTapped()
}
