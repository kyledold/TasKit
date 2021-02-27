//
//  TaskDetailsViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import Foundation

protocol TaskDetailsViewModelProtocol: ObservableObject {
    
    var taskName: String { get set }
    var priority: Priority { get set }
    var dueDate: Date { get set }
    var isComplete: Bool { get set }
    var taskNotes: String { get set }
    var taskNamePlaceholderText: String { get }
    var taskNotesPlaceholderText: String { get }
    var taskDateText: String { get }
    var cancelButtonText: String { get }
    var submitButtonText: String { get }
    
    func onAppear()
    func addNewTaskTapped(_ completion: @escaping EmptyClosure)
}
