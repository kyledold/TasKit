//
//  TaskRowViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

protocol TaskRowViewModelProtocol: ObservableObject {
    
    var id: UUID { get }
    var titleText: String { get }
    var priority: Priority { get }
    var isCompleted: Bool { get }
    
    func completeButtonTapped()
}

