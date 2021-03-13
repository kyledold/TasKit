//
//  TaskRowViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

protocol TaskRowViewModelProtocol: ObservableObject, Identifiable {
    
    var isComplete: Bool { get set }
    var id: UUID { get }
    var taskTitle: String { get }
    var task: Task { get }
}

