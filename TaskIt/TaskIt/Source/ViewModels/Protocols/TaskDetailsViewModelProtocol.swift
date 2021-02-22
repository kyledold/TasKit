//
//  TaskDetailsViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 21/02/2021.
//

import Foundation

protocol TaskDetailsViewModelProtocol {
    
    var titleText: String { get }
    var priority: Priority { get }
    var completeTaskButtonText: String { get }
    var cancelButtonText: String { get }
    var task: Task { get }
    
    func deleteTask(_ completion: @escaping EmptyClosure)
    func completeTask(_ completion: @escaping EmptyClosure)
}
