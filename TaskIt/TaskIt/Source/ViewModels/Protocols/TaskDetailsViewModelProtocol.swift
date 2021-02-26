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
    var submitButtonText: String { get }
    var cancelButtonText: String { get }
    var task: Task { get }
    var actionSheetTitle: String { get }
    var deleteText: String { get }
    var actionSheetMessage: String { get }
    
    func deleteButtonTapped(_ completion: @escaping EmptyClosure)
    func submitButtonTapped(_ completion: @escaping EmptyClosure)
}
