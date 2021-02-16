//
//  TasksViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine

protocol TasksViewModelProtocol: ObservableObject {
    
    var titleText: String { get }
    var tasks: [Task] { get }
    
    func fetchTasks()
}
