//
//  TasksViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import Foundation

protocol TasksViewModelProtocol: ObservableObject {
    
    var titleText: String { get }
    var taskViewModels: [TaskRowViewModelProtocol] { get }
    
    func fetchTasks()
    func deleteTask(at indexSet: IndexSet)
}
