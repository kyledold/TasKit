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
    var selectedStatusFilter: Status { get set }
    var titleText: String { get }
    var createTaskButtonText: String { get }
    var newTaskViewModel: NewTaskViewModel { get }
    
    func fetchTasks()
    func didChangeStatusFilter(status: Status)
}
