//
//  TaskRowViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

protocol TaskRowViewModelProtocol: ObservableObject, Identifiable {
    
    var id: UUID { get }
    var taskTitle: String { get }
    var dayOfTheWeekText: String { get }
    var dateText: String { get }
    var monthText: String { get }
    var priority: Priority { get }
    var isCompleted: Bool { get }
    var task: Task { get }
    
    func completeButtonTapped()
}

