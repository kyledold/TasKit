//
//  TaskRowViewModelProtocol.swift
//  TasKit
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

protocol TaskRowViewModelProtocol: ObservableObject, Identifiable {
    
    var isComplete: Bool { get set }
    var id: UUID { get }
    var title: String { get }
    var time: String? { get }
    var subTasksCompletionPercentage: Double? { get }
    var task: Task { get }
}
