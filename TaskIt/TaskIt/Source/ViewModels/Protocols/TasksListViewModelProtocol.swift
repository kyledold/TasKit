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
    
    var titleText: String { get }
    var taskViewModels: Array<RowViewModel> { get }
    var selectedStatusFilter: Status { get set }
    
    func fetchTasks()
    func deleteTask(at indexSet: IndexSet)
    func didChangeStatusFilter(status: Status)
}
