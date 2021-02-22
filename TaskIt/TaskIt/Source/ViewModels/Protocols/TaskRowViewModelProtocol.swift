//
//  TaskRowViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

protocol TaskRowViewModelProtocol: ObservableObject, Identifiable {
    
    var id: UUID { get }
    var titleText: String { get }
    var priority: Priority { get }
    var isCompleted: Bool { get }
    var task: Task { get }
    
    func completeButtonTapped()
}

