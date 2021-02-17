//
//  AddTaskViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine

protocol AddTaskViewModelProtocol: ObservableObject {
    
    var taskName: String { get set }
    var priority: Priority { get set }
    var taskNamePlaceholder: String { get }
    
    func onAppear()
    func addNewTaskTapped(_ completion: @escaping EmptyClosure)
}
