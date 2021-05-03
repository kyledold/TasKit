//
//  NewTaskViewModelProtocol.swift
//  TasKit
//
//  Created by Kyle Dold on 06/03/2021.
//

import Foundation

protocol NewTaskViewModelProtocol: ObservableObject {
    
    var taskName: String { get set }
    var isCreateButtonDisabled: Bool { get }
    var taskNamePlaceholder: String { get }
    var selectedDate: Date { get }
    var index: Int { get }
    
    func createTaskButtonTapped(_ completion: @escaping EmptyClosure)
}
