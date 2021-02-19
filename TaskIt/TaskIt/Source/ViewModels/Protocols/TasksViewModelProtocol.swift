//
//  TasksViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import Foundation

protocol TasksViewModelProtocol: ObservableObject {
    
    associatedtype RowViewModel: TaskRowViewModelProtocol
    
    var titleText: String { get }
    var taskViewModels: Array<RowViewModel> { get }
    
    func fetchTasks()
    func deleteTask(at indexSet: IndexSet)
}
