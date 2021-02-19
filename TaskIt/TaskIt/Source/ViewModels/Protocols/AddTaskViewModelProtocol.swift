//
//  AddTaskViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import Foundation

protocol AddTaskViewModelProtocol: ObservableObject {
    
    var taskName: String { get set }
    var priority: Priority { get set }
    var dueDate: Date { get set }
    var taskNamePlaceholderText: String { get }
    var taskDateText: String { get }
    
    func onAppear()
    func addNewTaskTapped(_ completion: @escaping EmptyClosure)
}
