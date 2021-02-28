//
//  TaskDetailsViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import Foundation

protocol TaskDetailsViewModelProtocol: ObservableObject {
    
    associatedtype RowViewModel: SubTaskRowViewModelProtocol
    
    var taskName: String { get set }
    var priority: Priority { get set }
    var dueDate: Date { get set }
    var isComplete: Bool { get set }
    var taskNotes: String { get set }
    var taskNamePlaceholderText: String { get }
    var subTaskNamePlaceholderText: String { get }
    var taskNotesPlaceholderText: String { get }
    var taskDateText: String { get }
    var submitButtonText: String { get }
    var newSubTaskName: String { get set }
    var subTaskModels: [RowViewModel] { get set }
    
    func onAppear()
    func addNewSubTaskButtonTapped(_ completion: @escaping EmptyClosure)
    func addNewTaskTapped(_ completion: @escaping EmptyClosure)
}
